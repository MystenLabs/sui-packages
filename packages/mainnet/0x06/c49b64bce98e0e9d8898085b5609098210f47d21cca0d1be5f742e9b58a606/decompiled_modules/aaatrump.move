module 0x6c49b64bce98e0e9d8898085b5609098210f47d21cca0d1be5f742e9b58a606::aaatrump {
    struct AAATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAATRUMP>(arg0, 6, b"AAATRUMP", b"AAA TRUMP", b"Hold the cat like Donaaald. $AAA is gonna be yuge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250121_100407_4f95febb44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

