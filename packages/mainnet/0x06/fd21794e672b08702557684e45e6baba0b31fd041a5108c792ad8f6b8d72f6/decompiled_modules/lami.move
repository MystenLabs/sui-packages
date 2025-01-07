module 0x6fd21794e672b08702557684e45e6baba0b31fd041a5108c792ad8f6b8d72f6::lami {
    struct LAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMI>(arg0, 6, b"LAMI", b"Lami The Kitty", b"The mischievous cat in Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LAMI_71c8beb874.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

