module 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points {
    struct PointsTreasuryCapOwner has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<VOULTRON_POINTS>,
    }

    struct VOULTRON_POINTS has drop {
        dummy_field: bool,
    }

    public(friend) fun get_mut_treasury_cap(arg0: &mut PointsTreasuryCapOwner) : &mut 0x2::coin::TreasuryCap<VOULTRON_POINTS> {
        &mut arg0.cap
    }

    public(friend) fun get_treasury_cap(arg0: &PointsTreasuryCapOwner) : &0x2::coin::TreasuryCap<VOULTRON_POINTS> {
        &arg0.cap
    }

    fun init(arg0: VOULTRON_POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<VOULTRON_POINTS>(arg0, 9, 0x1::string::utf8(b"VP"), 0x1::string::utf8(b"Voultron Points"), 0x1::string::utf8(b"Voultron Points"), 0x1::string::utf8(b"https://i.ibb.co/7J6HbMgw/19023983-431a-4013-9333-22ee8ff92c48.jpg"), arg1);
        let v2 = v1;
        let (v3, v4) = 0x2::token::new_policy<VOULTRON_POINTS>(&v2, arg1);
        0x2::token::share_policy<VOULTRON_POINTS>(v3);
        let v5 = PointsTreasuryCapOwner{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<VOULTRON_POINTS>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VOULTRON_POINTS>>(0x2::coin_registry::finalize<VOULTRON_POINTS>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<PointsTreasuryCapOwner>(v5);
    }

    // decompiled from Move bytecode v6
}

