module 0x21e7ccd73cd1d8c9a8ad86752ff2b3e9284796819370b40ef3aa78d08272cc72::dinoinu {
    struct DINOINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINOINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOINU>(arg0, 6, b"DINOINU", b"DINO INU", x"4f6620636f757273652065766572792064696e6f736175727320617265206269672e20457665727920626f6479206b6e6f777320746861742c2062757420746865726520776173206a757374206f6e652064696e6f73617572207468617420697320736d616c6c2e2044696e6f494e75207761736e27742062696720627574206861732062696767657220647265616d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_05_40_42_4600036c37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINOINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

