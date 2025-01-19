module 0xb829eb9becbb855de17577f4555355b4e5f08f70df2a76b22f72a91394800621::mongs {
    struct MONGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGS>(arg0, 6, b"MS3.0", b"MONGSUI3.0", b"https://t.me/MongSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/h0omlTj.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x6758d64e4d64de9615f6442dc41ea30d8374f3bc223d43e644d1679b6c094ca8;
        0x2::coin::mint_and_transfer<MONGS>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGS>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

