module 0x1be692f20b86698080c7d946eab2dc37622b50a69d313569b0c6fcc466be3e59::bippo {
    struct BIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIPPO>(arg0, 9, b"BIPPO", b"Baby Hippo", b"Franchise of the HIPPO meme with his sweet baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838038177912913920/55CPVIMX.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIPPO>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

