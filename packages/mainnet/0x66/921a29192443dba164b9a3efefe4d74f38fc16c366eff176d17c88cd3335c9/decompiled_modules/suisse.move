module 0x66921a29192443dba164b9a3efefe4d74f38fc16c366eff176d17c88cd3335c9::suisse {
    struct SUISSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSE>(arg0, 6, b"SUISSE", b"Credit Suisse", b"Credit Suisse is a major global financial institution, one of the largest banks in Switzerland, known for its investment banking, private banking, and wealth management services.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009797_74db10dbd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

