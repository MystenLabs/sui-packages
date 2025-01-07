module 0x5a13596c983c745415787c0cd69ef88ff5caa708d2fc2557e87241880416d23b::wig {
    struct WIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIG>(arg0, 6, b"WIG", b"Wig Pig", b"Wig pig on mission to munch and spread joy to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009270_fe7acf4aaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

