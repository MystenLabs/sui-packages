module 0xa18a23e8df1c8383db3e5af70a2c335a22ca54a56e93c1fc13082b87fa61f403::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 9, b"FIONA", b"Fiona On Sui", b"The most famous hippo and the ambassador for her species!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843759843972374528/u5B0er24.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIONA>(&mut v2, 499000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

