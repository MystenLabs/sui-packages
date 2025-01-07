module 0x44ec8f0a34dc10e4d978cbe1529aec77b78f48490da17aaa6a212d9763c8f574::soup {
    struct SOUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUP>(arg0, 6, b"SOUP", b"SOUP SUI", b"SOUP and his loyal companions have grown weary with the current state of the SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731167621739.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

