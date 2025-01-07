module 0x3c31e122fbdfd2a14591e7bd2a1f0111059c3747dd5ab661b7e1468f03295614::beeg {
    struct BEEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEG>(arg0, 6, b"BEEG", b"Beeg Blue Whale", x"4469766520696e746f2074686520646570746873206f6620746865202353756920206f6365616e2077697468204265656720426c7565205768616c652c206120756e6971756520636f6d6d756e6974792074686174207365656b7320746f206372656174652061207768616c6520636f6d6d756e69747920666c6f6174696e6720696e207468652063757272656e7473206f6620746865206469676974616c207365610a0a2442454547206f6e20537569204e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_WX_3_Ni_He_400x400_e7d4e5a994.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

