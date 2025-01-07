module 0x1871b7a3006ca49a5e69ca0bbd5dcb7bbade975dc9724d80e814abf8d7259f2a::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY>(arg0, 9, b"HOLY", b"Holy token", b"For individuals who are living in a Christ like manner and are also willing to share same crypto goals can come together through HOLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f8cf512-dd0b-4e0f-815e-f8f22727b41e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

