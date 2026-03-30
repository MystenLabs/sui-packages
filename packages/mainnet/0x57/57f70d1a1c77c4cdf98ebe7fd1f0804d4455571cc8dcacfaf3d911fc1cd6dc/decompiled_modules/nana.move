module 0x5757f70d1a1c77c4cdf98ebe7fd1f0804d4455571cc8dcacfaf3d911fc1cd6dc::nana {
    struct NANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANA>(arg0, 6, b"NANA", b"NANA", b"NANA is a meme coin inspired by the \"silly but adorable\" characters on the internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NANA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

