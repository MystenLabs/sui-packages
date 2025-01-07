module 0x3f588fb8ecd2507099aafd44dde5b9b14c1d3dcaac1bb4d8389224cde6ae122b::justin {
    struct JUSTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTIN>(arg0, 6, b"Justin", b"Justin APE", b"Justin the APE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5de6490b_904e_4d4e_9770_2216ff526b64_b0781bd3f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUSTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

