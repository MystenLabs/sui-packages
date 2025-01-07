module 0xab23b5474f1ac86df4e0ecf74ac7b64a95b472693e19c5cc435b89294a993d5a::space_gate {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Gate<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        min: u64,
        max: u64,
        balance: 0x2::balance::Balance<T0>,
        claim_fee: u64,
        fee: u64,
        total_claim: u64,
        total_fee: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        is_active: bool,
        multi_sig_address: address,
    }

    struct SpaceGate has copy, drop {
        sender: address,
        receiver: vector<u8>,
        receive_amount: u64,
        gate_id: vector<u8>,
    }

    struct PayGate has copy, drop {
        gate_id: vector<u8>,
        receiver: address,
        receive_amount: u64,
    }

    public fun space_gate<T0>(arg0: &Config, arg1: &mut Gate<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_active_config(arg0), 0);
        assert!(is_active_gate<T0>(arg1), 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(arg1.min <= v0 && v0 <= arg1.max, 2);
        let v1 = v0 * arg1.fee / 10000;
        let v2 = arg1.claim_fee;
        arg1.total_claim = arg1.total_claim + v2;
        arg1.total_fee = arg1.total_fee + v1;
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v3 = SpaceGate{
            sender         : 0x2::tx_context::sender(arg4),
            receiver       : arg3,
            receive_amount : v0 - v1 - v2,
            gate_id        : 0x2::object::uid_to_bytes(&arg1.id),
        };
        0x2::event::emit<SpaceGate>(v3);
    }

    public fun create_gate<T0>(arg0: &OwnerCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Gate<T0>{
            id          : 0x2::object::new(arg5),
            is_active   : true,
            min         : arg1,
            max         : arg2,
            balance     : 0x2::balance::zero<T0>(),
            claim_fee   : arg3,
            fee         : arg4,
            total_claim : 0,
            total_fee   : 0,
        };
        0x2::transfer::share_object<Gate<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id                : 0x2::object::new(arg0),
            is_active         : true,
            multi_sig_address : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    fun is_active_config(arg0: &Config) : bool {
        arg0.is_active
    }

    fun is_active_gate<T0>(arg0: &Gate<T0>) : bool {
        arg0.is_active
    }

    public fun owner_deposit_gate<T0>(arg0: &OwnerCap, arg1: &mut Gate<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun owner_withdraw_gate<T0>(arg0: &OwnerCap, arg1: &mut Gate<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg4), arg3);
    }

    public fun pay_gate<T0>(arg0: &Config, arg1: &mut Gate<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_active_config(arg0), 0);
        assert!(is_active_gate<T0>(arg1), 1);
        assert!(arg1.min <= arg2 && arg2 <= arg1.max, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.multi_sig_address, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg4), arg3);
        let v0 = PayGate{
            gate_id        : 0x2::object::uid_to_bytes(&arg1.id),
            receiver       : arg3,
            receive_amount : arg2,
        };
        0x2::event::emit<PayGate>(v0);
    }

    public fun set_active(arg0: &OwnerCap, arg1: &mut Config, arg2: bool) {
        arg1.is_active = arg2;
    }

    public fun set_active_gate<T0>(arg0: &OwnerCap, arg1: &mut Gate<T0>, arg2: bool) {
        arg1.is_active = arg2;
    }

    public fun set_cap_gate<T0>(arg0: &OwnerCap, arg1: &mut Gate<T0>, arg2: u64, arg3: u64) {
        arg1.min = arg2;
        arg1.max = arg3;
    }

    public fun set_fee_gate<T0>(arg0: &OwnerCap, arg1: &mut Gate<T0>, arg2: u64, arg3: u64) {
        arg1.fee = arg2;
        arg1.claim_fee = arg3;
    }

    public fun set_multi_sig(arg0: &OwnerCap, arg1: &mut Config, arg2: address) {
        arg1.multi_sig_address = arg2;
    }

    // decompiled from Move bytecode v6
}

