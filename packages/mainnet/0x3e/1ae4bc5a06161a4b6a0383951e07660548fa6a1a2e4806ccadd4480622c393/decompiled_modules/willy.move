module 0x3e1ae4bc5a06161a4b6a0383951e07660548fa6a1a2e4806ccadd4480622c393::willy {
    struct WILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILLY>(arg0, 6, b"WILLY", b"Willy The Whale", b"A real Sui Whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/willy_ce7c815490.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

