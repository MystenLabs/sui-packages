module 0xb6deae2a6b5c98d8aee31b2a5b74f87aafa9f7935be0d9ac4c8762980aa13516::beys {
    struct BEYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEYS>(arg0, 6, b"BEYS", b"Blue Eyes", b"Stare it. NOW!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000214014_5a1e094867.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

