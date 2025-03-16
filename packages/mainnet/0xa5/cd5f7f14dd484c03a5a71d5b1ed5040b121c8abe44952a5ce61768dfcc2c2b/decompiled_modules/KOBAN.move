module 0xa5cd5f7f14dd484c03a5a71d5b1ed5040b121c8abe44952a5ce61768dfcc2c2b::KOBAN {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<KOBAN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48 || 0x2::tx_context::sender(arg2) == @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<KOBAN>>(arg0, arg1);
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 9, b"KOBAN", b"KOBAN", b"One Token. One Ecosystem. Takibi Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafybeigbvvy3sg666337wocwqz4apm7g4aoey5flsfuweeciplmaunwdry")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KOBAN>>(0x2::coin::mint<KOBAN>(&mut v2, 1000000000000000000, arg1), @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KOBAN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

