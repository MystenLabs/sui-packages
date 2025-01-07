module 0x58334dcbaac2b6289750257b5ac93a57ff02354eefbd20ebc7244a5c0e038b86::realis {
    struct REALIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALIS>(arg0, 9, b"REALIS", b"Realis Worlds", b"Realis Worlds token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreifyu4urk5kkaczvsbjesituxbk3sgtzxebmkvigrbeoakl3y5p5au.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REALIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

