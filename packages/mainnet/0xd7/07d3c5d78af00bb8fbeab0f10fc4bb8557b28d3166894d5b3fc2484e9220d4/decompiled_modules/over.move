module 0xd707d3c5d78af00bb8fbeab0f10fc4bb8557b28d3166894d5b3fc2484e9220d4::over {
    struct OVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVER>(arg0, 6, b"OVER", b"It's Over", b"over", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreie652pcyalmjkd7bxfe62rxf2h73klomjgjy6uh4kfff4uew4s2om.ipfs.nftstorage.link")), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OVER>>(0x2::coin::mint<OVER>(&mut v3, 1000000000000000000, arg1), @0xde06e7ab60f89597530356efddda07b8146245063e5de5e18f646274d15a331d);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVER>>(v3, 0x2::object::id_address<0x2::coin::CoinMetadata<OVER>>(&v2));
    }

    // decompiled from Move bytecode v6
}

