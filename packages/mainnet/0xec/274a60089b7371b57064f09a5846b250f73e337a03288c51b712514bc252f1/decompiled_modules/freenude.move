module 0xec274a60089b7371b57064f09a5846b250f73e337a03288c51b712514bc252f1::freenude {
    struct FREENUDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREENUDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREENUDE>(arg0, 9, b"FREENUDE", b"$10 = Nude", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FREENUDE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREENUDE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREENUDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

