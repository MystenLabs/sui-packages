module 0xc98db89d9561cee39f9dfd58fb77287ca2dcea7f42608312aeb7accd3e9a4acd::simpcat {
    struct SIMPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPCAT>(arg0, 6, b"SIMPCAT", b"SUI SIMPCAT", b"Simpcat is a devoted degen. Focuses on getting the attention of sui community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240913_135606_280_68a7849df5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

