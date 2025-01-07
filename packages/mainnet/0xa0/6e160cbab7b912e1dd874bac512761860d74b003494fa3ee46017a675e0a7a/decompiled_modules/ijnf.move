module 0xa06e160cbab7b912e1dd874bac512761860d74b003494fa3ee46017a675e0a7a::ijnf {
    struct IJNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: IJNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IJNF>(arg0, 6, b"ijnf", b"oinojf", b"npin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IJNF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IJNF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IJNF>>(v1);
    }

    // decompiled from Move bytecode v6
}

