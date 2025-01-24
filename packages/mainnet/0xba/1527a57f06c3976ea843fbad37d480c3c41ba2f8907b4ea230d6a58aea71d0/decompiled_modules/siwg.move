module 0xba1527a57f06c3976ea843fbad37d480c3c41ba2f8907b4ea230d6a58aea71d0::siwg {
    struct SIWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIWG>(arg0, 9, b"SIWG", b"Shiba Inu Wearing glasses", b"Shiba Inu wearing glasses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://share.icloud.com/photos/076ZjNha4liTTNE1-wzA8pXBw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIWG>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIWG>>(v2, @0xebe37b7d8b17d43f703966d94af285b19cb0dd4389f5d5f14b9ccfb9ab51f14e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

