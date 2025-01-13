module 0xa2fbc828ef20de588317d9de20b2988d086f9eaee15c69ab01e9d93c691bcc5::yelon {
    struct YELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: YELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YELON>(arg0, 9, b"YELON", b"Yelon SpaceX", x"2459454c4f4e202d2020746865206d6f73742079656c6c6f77204149206167656e74206f6e2065617274682e204d75736b7320746f702066616e626f79202d206865207472756c792062656c696576657320696e2074686520667574757265206f6620746563686e6f6c6f677921200a0a54656c656772616d3a68747470733a2f2f742e6d652f59656c6f6e5370616365585c6e547769747465723a2068747470733a2f2f782e636f6d2f59656c6f6e5370616365585c6e576562736974653a2068747470733a2f2f79656c6f6e2e7370616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdpa5EQVCtexby4aH94AviyGcvxk6FmSZpAkZPcMqBaHR")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YELON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YELON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

