module 0x721c2a55071c64539989f003202f1b03499881878d44e742202d4cdfe7baca75::mtx {
    struct MTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTX>(arg0, 9, b"MTX", b"Matrix", b"Matrix Test Airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/bkpNPlK.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MTX>(&mut v2, 69420000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTX>>(v1);
    }

    // decompiled from Move bytecode v6
}

