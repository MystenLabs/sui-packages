module 0xb6229b404f74a487858c3d55fb5e62d3a05326aaca2e6c123fbbeb0bbd8dd37a::steam {
    struct STEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEAM>(arg0, 9, b"STEAM", b"Steam", b"Steam - the first AI hedge fund for AI projects investment on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.ap-southeast-1.amazonaws.com/nfts.steampunk.game/coins/steam.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEAM>>(v1);
        0x2::coin::mint_and_transfer<STEAM>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STEAM>>(v2);
    }

    // decompiled from Move bytecode v6
}

