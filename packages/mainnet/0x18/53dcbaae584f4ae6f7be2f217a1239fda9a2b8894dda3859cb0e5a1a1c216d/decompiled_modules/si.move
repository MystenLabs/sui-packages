module 0x1853dcbaae584f4ae6f7be2f217a1239fda9a2b8894dda3859cb0e5a1a1c216d::si {
    struct SI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SI>(arg0, 9, b"SI", b"siu", b"ronaldo coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SI>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SI>>(v2, @0xf110f0f47d28d782fb4f2fae7d5f949466a1d27754b6e9b38e0e0ccb266ca213);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SI>>(v1);
    }

    // decompiled from Move bytecode v6
}

