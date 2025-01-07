module 0xd486d42ba7400c797440299f4b5d99fef9bed6a5ddec2c3e9c2b766f46764021::yen {
    struct YEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEN>(arg0, 9, b"YEN", b"The Yen Of Sui", b"This is the yen of sui blockchain https://pbs.twimg.com/profile_images/1615575809690927104/ySFkBqaD.jpg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YEN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

