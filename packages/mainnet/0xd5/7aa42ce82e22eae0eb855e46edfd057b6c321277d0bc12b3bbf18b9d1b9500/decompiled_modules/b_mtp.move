module 0xd57aa42ce82e22eae0eb855e46edfd057b6c321277d0bc12b3bbf18b9d1b9500::b_mtp {
    struct B_MTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MTP>(arg0, 9, b"bMTP", b"bToken MTP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

