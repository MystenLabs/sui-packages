module 0x46dd2b7820ca3dbd59fbb768c608ee3340d9c9d45a760a11fd091ae889343318::community {
    struct COMMUNITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMMUNITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775159016294-f2677e9012ba023e9b212cfe1025d815.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775159016294-f2677e9012ba023e9b212cfe1025d815.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<COMMUNITY>(arg0, 9, b"Community", b"Community Coin", b"Sui Community is the token native", v1, arg1);
        let v4 = v2;
        if (10000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<COMMUNITY>(&mut v4, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMMUNITY>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COMMUNITY>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

