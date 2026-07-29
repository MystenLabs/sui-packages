module 0x33d5d3dfda5667a684fdd99cbfc1d49f6ba178156ca95f15e852b3183d8a876f::hWAL {
    struct HWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWAL>(arg0, 9, b"hWAL", b"hWAL Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hwal_666658cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HWAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

