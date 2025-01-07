module 0x21513c07d67adaee4347c585e934c9d8970fd068d81c21b9b59bd7186b214953::utya {
    struct UTYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTYA>(arg0, 6, b"UTYA", b"SUI UTYA", b"Chill with utya ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GUOR_Fv7_WMA_Atyk_W_a3d017e71c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

