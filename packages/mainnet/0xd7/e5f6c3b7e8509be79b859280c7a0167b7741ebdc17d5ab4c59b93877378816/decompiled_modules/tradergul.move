module 0xd7e5f6c3b7e8509be79b859280c7a0167b7741ebdc17d5ab4c59b93877378816::tradergul {
    struct TRADERGUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADERGUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRADERGUL>(arg0, 9, b"TraderGul", b"crptogul", b"trader", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4d5c37317296a1b40a2b6e28a46b8f22blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRADERGUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADERGUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

