module 0x95256248d1ea3453436a4471ac499b7f976aad037fe26b47873d3ac66cd4601b::bv2 {
    struct BV2 has drop {
        dummy_field: bool,
    }

    struct BoeierTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BoeierBurned has copy, drop {
        burner: address,
        amount: u64,
        comment: 0x1::string::String,
        burned_at: u64,
    }

    struct BurnCommentMaxLengthOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct BurnCommentMaxLength has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun total_supply(arg0: &BoeierTreasury) : u64 {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::coin::total_supply<BV2>(0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<BV2>>(&arg0.id, v0))
    }

    public entry fun burn_mfer(arg0: &mut BoeierTreasury, arg1: 0x2::coin::Coin<BV2>, arg2: vector<u8>, arg3: &BurnCommentMaxLength, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::vector::length<u8>(&arg2) <= arg3.value, 0);
        let v0 = TreasuryCapKey{dummy_field: false};
        let v1 = 0x2::coin::burn<BV2>(0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<BV2>>(&mut arg0.id, v0), arg1);
        let v2 = BoeierBurned{
            burner    : 0x2::tx_context::sender(arg5),
            amount    : v1,
            comment   : 0x1::string::utf8(arg2),
            burned_at : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BoeierBurned>(v2);
        v1
    }

    fun init(arg0: BV2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 7;
        let (v1, v2) = 0x2::coin::create_currency<BV2>(arg0, v0, b"BV2", b"BV2", b"The native token for the BV2.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<BV2>(&mut v3, 690000000 * 0x1::u64::pow(10, v0), 0x2::tx_context::sender(arg1), arg1);
        let v4 = BoeierTreasury{id: 0x2::object::new(arg1)};
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<BV2>>(&mut v4.id, v5, v3);
        let v6 = BurnCommentMaxLengthOwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BurnCommentMaxLengthOwnerCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = BurnCommentMaxLength{
            id    : 0x2::object::new(arg1),
            value : 42,
        };
        0x2::transfer::share_object<BurnCommentMaxLength>(v7);
        0x2::transfer::share_object<BoeierTreasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BV2>>(v2);
    }

    public entry fun set_burn_comment_length(arg0: &BurnCommentMaxLengthOwnerCap, arg1: &mut BurnCommentMaxLength, arg2: u64) {
        arg1.value = arg2;
    }

    // decompiled from Move bytecode v6
}

