module 0x5ec882e81ae5ce04eb3166fbc391b8cd0081e45aa03a76b6215f6bdab57fa055::kfc {
    struct KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFC>(arg0, 9, b"KFC", b"KFC", b"KFC Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KFC>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

