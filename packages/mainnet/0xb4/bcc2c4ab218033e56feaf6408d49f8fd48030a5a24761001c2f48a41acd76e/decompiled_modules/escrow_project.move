module 0xb4bcc2c4ab218033e56feaf6408d49f8fd48030a5a24761001c2f48a41acd76e::escrow_project {
    struct Plan has copy, drop, store {
        fee_bps: u64,
    }

    struct EscrowState has copy, drop, store {
        value: u8,
    }

    struct Escrow<phantom T0> has store, key {
        id: 0x2::object::UID,
        buyer: address,
        seller: address,
        amount: u64,
        admin_addresses: vector<address>,
        escrow_id: u64,
        state: EscrowState,
        delivery_confirmed: bool,
        created_at: u64,
        vault: 0x2::balance::Balance<T0>,
    }

    struct EscrowCap has store, key {
        id: 0x2::object::UID,
        escrow_id: u64,
    }

    struct EscrowInitialized has copy, drop {
        escrow_id: u64,
        buyer: address,
        seller: address,
        amount: u64,
        fee_amount: u64,
        net_amount: u64,
    }

    struct DeliveryConfirmed has copy, drop {
        escrow_id: u64,
        amount: u64,
    }

    struct DisputeResolved has copy, drop {
        escrow_id: u64,
        winner: address,
        amount: u64,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: u64,
        amount: u64,
    }

    public fun admin_release_to_buyer<T0>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == @0xd1bf14378247937b934d3800af5b50c0061d811d955fec04005e88e75ad682ca, 3);
        assert!(is_state_active(&arg0.state), 2);
        arg0.state = state_dispute_resolved_buyer();
        let v0 = DisputeResolved{
            escrow_id : arg0.escrow_id,
            winner    : arg0.buyer,
            amount    : 0x2::balance::value<T0>(&arg0.vault),
        };
        0x2::event::emit<DisputeResolved>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.vault), arg1)
    }

    public entry fun admin_release_to_buyer_and_transfer<T0>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = admin_release_to_buyer<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.buyer);
    }

    public fun admin_release_to_seller<T0>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == @0xd1bf14378247937b934d3800af5b50c0061d811d955fec04005e88e75ad682ca, 3);
        assert!(is_state_active(&arg0.state), 2);
        arg0.state = state_dispute_resolved_seller();
        let v0 = DisputeResolved{
            escrow_id : arg0.escrow_id,
            winner    : arg0.seller,
            amount    : 0x2::balance::value<T0>(&arg0.vault),
        };
        0x2::event::emit<DisputeResolved>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.vault), arg1)
    }

    public entry fun admin_release_to_seller_and_transfer<T0>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = admin_release_to_seller<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.seller);
    }

    public fun cancel_escrow<T0>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.buyer || v0 == @0xd1bf14378247937b934d3800af5b50c0061d811d955fec04005e88e75ad682ca, 3);
        assert!(is_state_active(&arg0.state), 2);
        arg0.state = state_cancelled();
        let v1 = EscrowCancelled{
            escrow_id : arg0.escrow_id,
            amount    : 0x2::balance::value<T0>(&arg0.vault),
        };
        0x2::event::emit<EscrowCancelled>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.vault), arg1)
    }

    public entry fun cancel_escrow_and_refund<T0>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_escrow<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.buyer);
    }

    public fun confirm_delivery<T0>(arg0: &mut Escrow<T0>, arg1: &EscrowCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.buyer, 3);
        assert!(is_state_active(&arg0.state), 2);
        arg0.state = state_completed_delivery();
        arg0.delivery_confirmed = true;
        let v0 = DeliveryConfirmed{
            escrow_id : arg0.escrow_id,
            amount    : 0x2::balance::value<T0>(&arg0.vault),
        };
        0x2::event::emit<DeliveryConfirmed>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.vault), arg2)
    }

    public entry fun confirm_delivery_and_transfer<T0>(arg0: &mut Escrow<T0>, arg1: &EscrowCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = confirm_delivery<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.seller);
    }

    public entry fun create_escrow<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<address>, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2, v3) = initialize_escrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::share_object<Escrow<T0>>(v1);
        0x2::transfer::transfer<EscrowCap>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, @0xd1bf14378247937b934d3800af5b50c0061d811d955fec04005e88e75ad682ca);
    }

    public fun get_escrow_info<T0>(arg0: &Escrow<T0>) : (address, address, u64, u64, bool, u64) {
        (arg0.buyer, arg0.seller, arg0.amount, arg0.escrow_id, arg0.delivery_confirmed, arg0.created_at)
    }

    public fun get_escrow_state<T0>(arg0: &Escrow<T0>) : u8 {
        arg0.state.value
    }

    public fun get_vault_balance<T0>(arg0: &Escrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun initialize_escrow<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: vector<address>, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Escrow<T0>, EscrowCap, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::length<address>(&arg2) == 1, 1);
        assert!(*0x1::vector::borrow<address>(&arg2, 0) == @0xd1bf14378247937b934d3800af5b50c0061d811d955fec04005e88e75ad682ca, 1);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 5);
        let v2 = if (arg4 == 0) {
            plan_free()
        } else if (arg4 == 1) {
            plan_pro()
        } else {
            plan_premium()
        };
        let v3 = v2;
        let v4 = v1 * v3.fee_bps / 10000;
        let v5 = v1 - v4;
        let v6 = Escrow<T0>{
            id                 : 0x2::object::new(arg6),
            buyer              : v0,
            seller             : arg1,
            amount             : v5,
            admin_addresses    : arg2,
            escrow_id          : arg3,
            state              : state_active(),
            delivery_confirmed : false,
            created_at         : 0x2::clock::timestamp_ms(arg5),
            vault              : 0x2::coin::into_balance<T0>(arg0),
        };
        let v7 = EscrowCap{
            id        : 0x2::object::new(arg6),
            escrow_id : arg3,
        };
        let v8 = EscrowInitialized{
            escrow_id  : arg3,
            buyer      : v0,
            seller     : arg1,
            amount     : v1,
            fee_amount : v4,
            net_amount : v5,
        };
        0x2::event::emit<EscrowInitialized>(v8);
        (v6, v7, 0x2::coin::split<T0>(&mut arg0, v4, arg6))
    }

    fun is_state_active(arg0: &EscrowState) : bool {
        arg0.value == 0
    }

    fun plan_free() : Plan {
        Plan{fee_bps: 350}
    }

    fun plan_premium() : Plan {
        Plan{fee_bps: 150}
    }

    fun plan_pro() : Plan {
        Plan{fee_bps: 250}
    }

    fun state_active() : EscrowState {
        EscrowState{value: 0}
    }

    fun state_cancelled() : EscrowState {
        EscrowState{value: 4}
    }

    fun state_completed_delivery() : EscrowState {
        EscrowState{value: 1}
    }

    fun state_dispute_resolved_buyer() : EscrowState {
        EscrowState{value: 2}
    }

    fun state_dispute_resolved_seller() : EscrowState {
        EscrowState{value: 3}
    }

    public fun transfer_fee_to_recipient<T0>(arg0: 0x2::coin::Coin<T0>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0xd1bf14378247937b934d3800af5b50c0061d811d955fec04005e88e75ad682ca);
    }

    public fun transfer_to_buyer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public fun transfer_to_seller<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

