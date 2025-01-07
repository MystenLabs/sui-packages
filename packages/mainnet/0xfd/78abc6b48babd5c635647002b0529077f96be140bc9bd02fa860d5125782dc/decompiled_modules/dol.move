module 0xfd78abc6b48babd5c635647002b0529077f96be140bc9bd02fa860d5125782dc::dol {
    struct DOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOL>(arg0, 6, b"DOL", b"DOLPH", b"if you buy, sell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zdc_MUDXYAACO_8_L_8bdd8f547d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

