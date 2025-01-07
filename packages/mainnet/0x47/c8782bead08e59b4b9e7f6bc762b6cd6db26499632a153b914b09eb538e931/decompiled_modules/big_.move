module 0x47c8782bead08e59b4b9e7f6bc762b6cd6db26499632a153b914b09eb538e931::big_ {
    struct BIG_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG_>(arg0, 9, b"BIG", b"BIG SUI", b"big on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIG_>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIG_>>(v1);
    }

    // decompiled from Move bytecode v6
}

