module 0xbba683d2c77f651735c7058a4701d43ac137304f6024f7cf3b89b88f4b303a1::spnut {
    struct SPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPNUT>(arg0, 6, b"Spnut", b"Baby Pnut", b"Baby pnut coming on sui now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/babypnut_8b3d14ba90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

