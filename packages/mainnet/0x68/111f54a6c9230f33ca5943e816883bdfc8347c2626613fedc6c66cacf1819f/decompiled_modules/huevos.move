module 0x68111f54a6c9230f33ca5943e816883bdfc8347c2626613fedc6c66cacf1819f::huevos {
    struct HUEVOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUEVOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUEVOS>(arg0, 6, b"HUEVOS", b"HUEVOS ON SUI", b"I am the first Bitcoin mascot on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1x1_1_300x300_e2a8b21921.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUEVOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUEVOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

