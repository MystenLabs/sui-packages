module 0x6fb14b67a138366a926413347a52b6df2803dc845c227ec0bd5fda76f2a32416::gay {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 6, b"gay", b"gay", b"gaye", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/4/40/Image_test.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

