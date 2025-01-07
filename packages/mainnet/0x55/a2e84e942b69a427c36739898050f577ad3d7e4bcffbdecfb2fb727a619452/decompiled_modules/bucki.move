module 0x55a2e84e942b69a427c36739898050f577ad3d7e4bcffbdecfb2fb727a619452::bucki {
    struct BUCKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKI>(arg0, 6, b"BUCKI", b"bucki dog", b"$BUCKI is a memecoin with no intrinsic value or expectation of financial profit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000118361_e17cf5c0a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

