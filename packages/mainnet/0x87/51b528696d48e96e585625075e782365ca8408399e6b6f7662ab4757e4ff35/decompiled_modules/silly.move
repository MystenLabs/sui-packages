module 0x8751b528696d48e96e585625075e782365ca8408399e6b6f7662ab4757e4ff35::silly {
    struct SILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLY>(arg0, 6, b"SILLY", b"Silly Salmon", b"The splashiest meme token on the SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Silly_41551b882a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

