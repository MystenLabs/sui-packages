module 0x330e4224438b15f768b5fbfe89a7462bc0ca96d17695d7d17d37ab4bb8f5d492::owr {
    struct OWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWR>(arg0, 9, b"owr", b"One Way", b"Doge One Way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.uline.com/Product/Detail/H-5757/Parking-and-Traffic-Signs/One-Way-with-Right-Arrow-Sign-36-x-12")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OWR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

