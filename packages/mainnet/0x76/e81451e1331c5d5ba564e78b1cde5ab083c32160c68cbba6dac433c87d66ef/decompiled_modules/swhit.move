module 0x76e81451e1331c5d5ba564e78b1cde5ab083c32160c68cbba6dac433c87d66ef::swhit {
    struct SWHIT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct FeeCollector has store, key {
        id: 0x2::object::UID,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TokensMinted has copy, drop {
        minter: address,
        amount: u64,
        fee_paid: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWHIT>, arg1: &AdminCap, arg2: 0x2::coin::Coin<SWHIT>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 2);
        0x2::coin::burn<SWHIT>(arg0, arg2);
    }

    public entry fun admin_mint(arg0: &mut 0x2::coin::TreasuryCap<SWHIT>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 2);
        0x2::coin::mint_and_transfer<SWHIT>(arg0, arg2, arg3, arg4);
        let v0 = TokensMinted{
            minter   : arg1.admin,
            amount   : arg2,
            fee_paid : 0,
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public fun get_collected_fees(arg0: &FeeCollector) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees)
    }

    public fun get_mint_fee() : u64 {
        800000000
    }

    fun init(arg0: SWHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWHIT>(arg0, 9, b"SWHIT", b"WheatChain", x"5768656174436861696e2773206e617469766520746f6b656e20706f776572696e67207375737461696e61626c652067726f7774682c207374616b696e6720726577617264732c20616e6420736f6369616c20646973747269627574696f6e20e28094206275696c7420666f72206c617374696e672076616c7565206f6e2053554920616e64206265796f6e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/wheat-eco/Aptos-Tokens/refs/heads/main/logos/SWHIT.png")), arg1);
        let v2 = AdminCap{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        let v3 = FeeCollector{
            id             : 0x2::object::new(arg1),
            collected_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWHIT>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SWHIT>>(v0);
        0x2::transfer::public_share_object<FeeCollector>(v3);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_with_fee(arg0: &mut 0x2::coin::TreasuryCap<SWHIT>, arg1: &mut FeeCollector, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= 800000000, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, 800000000, arg4)));
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::coin::mint_and_transfer<SWHIT>(arg0, arg3, v0, arg4);
        let v1 = TokensMinted{
            minter   : v0,
            amount   : arg3,
            fee_paid : 800000000,
        };
        0x2::event::emit<TokensMinted>(v1);
    }

    public entry fun withdraw_all_fees(arg0: &mut FeeCollector, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.collected_fees, v0, arg2), arg1.admin);
            let v1 = FeesWithdrawn{
                amount    : v0,
                recipient : arg1.admin,
            };
            0x2::event::emit<FeesWithdrawn>(v1);
        };
    }

    public entry fun withdraw_fees(arg0: &mut FeeCollector, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 2);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.collected_fees, arg2, arg3), arg1.admin);
        let v0 = FeesWithdrawn{
            amount    : arg2,
            recipient : arg1.admin,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

