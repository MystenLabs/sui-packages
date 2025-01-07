module 0x8f15ea060daca48c92d9a04f2dd1b980c6d0602cef972ac845531cbc157ed0a2::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"Siu On sui", b"siu meme on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_3_ad8333d380.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

