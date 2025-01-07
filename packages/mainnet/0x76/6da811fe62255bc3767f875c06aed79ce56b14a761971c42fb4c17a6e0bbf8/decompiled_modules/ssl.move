module 0x766da811fe62255bc3767f875c06aed79ce56b14a761971c42fb4c17a6e0bbf8::ssl {
    struct SSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSL>(arg0, 9, b"SSL", b"Seashell", b"It's just a Seashell..!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://png.pngtree.com/png-vector/20230817/ourmid/pngtree-sticker-of-a-sea-shell-that-has-colored-shells-clipart-vector-png-image_7003004.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSL>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

