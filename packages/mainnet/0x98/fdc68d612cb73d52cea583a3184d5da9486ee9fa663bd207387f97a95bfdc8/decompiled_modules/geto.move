module 0x98fdc68d612cb73d52cea583a3184d5da9486ee9fa663bd207387f97a95bfdc8::geto {
    struct GETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GETO>(arg0, 6, b"GETO", b"Suguru Geto", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvy5lfff3jyhosgz24tsbonbpmmsssi4lq3xflp7pvwiqmowtfv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GETO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GETO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

