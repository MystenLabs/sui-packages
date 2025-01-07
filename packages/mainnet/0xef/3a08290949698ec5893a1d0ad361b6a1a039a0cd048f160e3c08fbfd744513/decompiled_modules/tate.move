module 0xef3a08290949698ec5893a1d0ad361b6a1a039a0cd048f160e3c08fbfd744513::tate {
    struct TATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATE>(arg0, 6, b"Tate", b"Tate Terminal", b"AI is going to change the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tate_f502911365.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

