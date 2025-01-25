module 0x79fed0f2f5a84ceb39cb65d64a84505cf549736b53c63ce998c4a0af71f7117d::cpx {
    struct CPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPX>(arg0, 6, b"CPX", b"Cyber Pirates X", x"4379626572205069726174657320697320612063757474696e672d656467652050324520576562332067616d65206f6e2074686520537569204e6574776f726b2e204275696c6420796f75720a666c6565742c20726563727569742063726577732c20676174686572207265736f75726365732c20616e6420646f6d696e617465207468652068696768207365617320696e20746872696c6c696e67205056450a616e642050565020626174746c657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8dae8255_f638_4c57_b3df_c34cde1a1e90_4aba5cf5c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

