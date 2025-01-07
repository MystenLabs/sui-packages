module 0x9f86642aaa67deb2685e69b5e78ea4e995374970107f069974cea0ffd5de82a7::bangbang {
    struct BANGBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANGBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANGBANG>(arg0, 9, b"BANGBANG", b"Bang", b"Bang bang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3f039d9-b520-44c8-826c-bf442db961dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANGBANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANGBANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

