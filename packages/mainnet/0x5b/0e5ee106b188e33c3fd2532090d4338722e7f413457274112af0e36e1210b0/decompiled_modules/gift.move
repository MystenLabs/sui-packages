module 0x5b0e5ee106b188e33c3fd2532090d4338722e7f413457274112af0e36e1210b0::gift {
    struct GIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIFT>(arg0, 9, b"GIFT", b"GIFT On SUI", x"596f7572204368726973746d617320244749465420f09f8e81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme3J6wmmK7MJJM4d3bEWhTVrfuCRS8dLenXUfiSNJMweZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIFT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIFT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

