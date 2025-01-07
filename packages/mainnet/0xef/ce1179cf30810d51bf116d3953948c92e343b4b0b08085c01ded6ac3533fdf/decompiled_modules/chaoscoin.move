module 0xefce1179cf30810d51bf116d3953948c92e343b4b0b08085c01ded6ac3533fdf::chaoscoin {
    struct CHAOSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOSCOIN>(arg0, 0, b"CHAOSCOIN", b"CHAOSCOIN", b"TESTCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/44160914")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAOSCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOSCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHAOSCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHAOSCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

