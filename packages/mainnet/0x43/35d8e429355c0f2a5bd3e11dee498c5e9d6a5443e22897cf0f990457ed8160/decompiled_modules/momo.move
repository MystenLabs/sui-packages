module 0x4335d8e429355c0f2a5bd3e11dee498c5e9d6a5443e22897cf0f990457ed8160::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 9, b"MOMO", b"MOMO", b"Meme for momo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"instagram.com/gero.momo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOMO>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

