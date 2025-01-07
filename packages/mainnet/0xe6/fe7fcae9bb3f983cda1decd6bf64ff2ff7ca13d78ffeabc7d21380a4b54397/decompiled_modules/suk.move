module 0xe6fe7fcae9bb3f983cda1decd6bf64ff2ff7ca13d78ffeabc7d21380a4b54397::suk {
    struct SUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUK>(arg0, 6, b"SUK", b"Sui Duk", b"sUk to a bUk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7663_4f44a1cc68.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

