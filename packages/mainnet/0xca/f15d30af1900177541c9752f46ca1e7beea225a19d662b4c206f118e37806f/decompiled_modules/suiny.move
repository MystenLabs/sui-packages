module 0xcaf15d30af1900177541c9752f46ca1e7beea225a19d662b4c206f118e37806f::suiny {
    struct SUINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINY>(arg0, 6, b"SUINY", b"SUINY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://twitter.com/PigEveryHour/photo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

