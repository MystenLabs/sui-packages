module 0x41a582288996bf947deb72d468ce99c030ce5cfb180e4cf87ff9fb46f634b12f::tan {
    struct TAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAN>(arg0, 9, b"TAN", b"TAN", b"TAN represents the platform token linked to TanTV, offering ownership in the platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWDUbwmFuPDy9mW5jRk4h7v1nhnXUr1jmmna6jHA3Npfo")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAN>>(v1);
        0x2::coin::mint_and_transfer<TAN>(&mut v2, 10000000000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

