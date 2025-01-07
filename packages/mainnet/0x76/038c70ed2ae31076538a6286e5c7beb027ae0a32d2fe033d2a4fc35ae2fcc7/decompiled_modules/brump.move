module 0x76038c70ed2ae31076538a6286e5c7beb027ae0a32d2fe033d2a4fc35ae2fcc7::brump {
    struct BRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUMP>(arg0, 6, b"BRUMP", b"Brett Trump", b"ONE OF CRYPTOS MOST SIGNIFICANT CULTURAL ICONS AND THE MASCOT OF SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001845_30e4bc44d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

