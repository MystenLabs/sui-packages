module 0x490710ee7e5424779ba173f8d4bae76b20e673df228911b7f9e04430d168c3d2::cex {
    struct CEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEX>(arg0, 5, b"CEX", b"NOCENOSEX", b"No CEX No SEX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1744355559539621888/4JBkKWI4_400x400.jpg")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CEX>(&mut v2, 200000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEX>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

