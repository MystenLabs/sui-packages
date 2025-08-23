module 0xf5a6e18a490bc1bfcd9ab1b94a0a1ba22fcd6518bbc146ef58a4516b9575e7f7::kar {
    struct KAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAR>(arg0, 9, b"Kar", b"Kari", b"Kar kar kar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAR>>(v2, @0xf16666d0ec949f88bc113eca7575f8d7171574600b6f3b635a41dcb06d182ff8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

