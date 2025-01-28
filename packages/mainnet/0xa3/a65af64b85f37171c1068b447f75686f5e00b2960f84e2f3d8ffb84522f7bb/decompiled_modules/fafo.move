module 0xa3a65af64b85f37171c1068b447f75686f5e00b2960f84e2f3d8ffb84522f7bb::fafo {
    struct FAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFO>(arg0, 6, b"FAFO", b"Fvck Around Find Out", b"Fvck the spammers. Socials on the thread. Send it before sol boys come in. Phantom wallet will come soon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1457_f736a7dfe3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

