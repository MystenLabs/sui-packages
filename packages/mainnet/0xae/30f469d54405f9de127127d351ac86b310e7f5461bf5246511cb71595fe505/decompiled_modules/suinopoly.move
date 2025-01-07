module 0xae30f469d54405f9de127127d351ac86b310e7f5461bf5246511cb71595fe505::suinopoly {
    struct SUINOPOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOPOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOPOLY>(arg0, 6, b"SUINOPOLY", b"SUIMONEY", b"money used for the fish on the sui water chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b7ff1a57_871c_4510_83af_00a69d37949d_1887a4a9f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOPOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOPOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

