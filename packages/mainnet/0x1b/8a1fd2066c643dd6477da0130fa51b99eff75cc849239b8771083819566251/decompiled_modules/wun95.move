module 0x1b8a1fd2066c643dd6477da0130fa51b99eff75cc849239b8771083819566251::wun95 {
    struct WUN95 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUN95, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUN95>(arg0, 9, b"WUN95", x"77756e39352d61d196efbda1636f6d", b"Official wun 95 token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/pod_public/1300/107221.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WUN95>(&mut v2, 9800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUN95>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUN95>>(v1);
    }

    // decompiled from Move bytecode v6
}

