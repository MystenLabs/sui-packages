module 0xcebbdb157f38d75de9ae0a282a9c30283eed69285b3a5a153e08c5cfb246479e::zap {
    struct ZAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAP>(arg0, 6, b"ZAP", b"Zap", b"Zap live now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/acd9007c_15aa_41d8_8e0e_e232ff2471d8_98539abae6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

