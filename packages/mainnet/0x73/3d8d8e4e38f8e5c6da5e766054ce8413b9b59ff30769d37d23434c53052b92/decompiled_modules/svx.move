module 0x733d8d8e4e38f8e5c6da5e766054ce8413b9b59ff30769d37d23434c53052b92::svx {
    struct SVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVX>(arg0, 9, b"SVX", b"SuiVerseX", b"Welcome to the Sui Verse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SVX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVX>>(v1);
    }

    // decompiled from Move bytecode v6
}

