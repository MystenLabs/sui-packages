module 0x4647f792f82b10550cbc08e7296b71b9a3276caa139e0a61ce251d5ecf19e0d3::bonkgirl {
    struct BONKGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKGIRL>(arg0, 9, b"Bonkgirl", b"BonkGirl", b"Twitter: https://x.com/bonkgirlonsol/status/1949451625049071987 | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihzv4n5whgpngqxkb2yvnkz3ytdcjkmhuikkie27zfivygua4myhe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BONKGIRL>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKGIRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

