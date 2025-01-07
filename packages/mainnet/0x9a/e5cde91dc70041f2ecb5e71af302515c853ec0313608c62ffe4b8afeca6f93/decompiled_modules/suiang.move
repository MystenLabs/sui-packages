module 0x9ae5cde91dc70041f2ecb5e71af302515c853ec0313608c62ffe4b8afeca6f93::suiang {
    struct SUIANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANG>(arg0, 6, b"SUIANG", b"Sui Ang", b"AAng is the only Sui Bender", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_e8251e1174.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

