module 0xed66cf812bd02b9f62960172085919b2f02f93b50a289284b17ca6a8d8ed76f2::five {
    struct FIVE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<FIVE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48 || 0x2::tx_context::sender(arg2) == @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<FIVE>>(arg0, arg1);
    }

    fun init(arg0: FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVE>(arg0, 9, b"five", b"just buy $5 and leave it alone", b"just buy $5 and leave it alone bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ivory-wrong-vicuna-814.mypinata.cloud/ipfs/bafybeic46rm5pvqw4u4w5nxrsosh5u2ofojq3ngdmiqjgrhxgvof3hktay")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FIVE>>(0x2::coin::mint<FIVE>(&mut v2, 10000000000000000, arg1), @0xd20c9257144ccd13c203fadb05212d7fddbc1ce15875c6582131c3fe1b25de48);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FIVE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

