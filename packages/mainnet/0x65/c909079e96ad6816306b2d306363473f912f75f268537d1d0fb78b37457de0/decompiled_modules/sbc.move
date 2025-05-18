module 0x65c909079e96ad6816306b2d306363473f912f75f268537d1d0fb78b37457de0::sbc {
    struct SBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBC>(arg0, 6, b"SBC", b"Sea Bunny Coin", x"5365612042756e6e7920436f696e2069736ee2809974206a75737420616e6f74686572206d656d6520746f6b656e20e28094206974206861732068656172742c2076697375616c732c20616e6420707572706f73652e204974e280997320612073796d626f6c206f66206861726d6f6e79206265747765656e207465636820616e64206e61747572652c207769746820636f6d6d756e6974792d64726976656e20636f6e736572766174696f6e2061742069747320636f72652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747552395991.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

