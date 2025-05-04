module 0x44ad862ad4360d114856058a8fc30a604c536751a67c107806290b77533d2e7c::baji {
    struct BAJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAJI>(arg0, 9, b"baji", b"baji", b"its a test just chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAJI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAJI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

