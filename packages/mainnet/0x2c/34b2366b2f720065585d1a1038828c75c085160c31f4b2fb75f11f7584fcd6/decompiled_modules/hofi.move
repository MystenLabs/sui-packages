module 0x2c34b2366b2f720065585d1a1038828c75c085160c31f4b2fb75f11f7584fcd6::hofi {
    struct HOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOFI>(arg0, 9, b"hofi", b"hofi", b"hofi is a new crypto and seeing what this site does", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOFI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

