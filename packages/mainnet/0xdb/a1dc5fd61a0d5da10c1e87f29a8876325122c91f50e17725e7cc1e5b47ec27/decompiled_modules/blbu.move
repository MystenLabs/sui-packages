module 0xdba1dc5fd61a0d5da10c1e87f29a8876325122c91f50e17725e7cc1e5b47ec27::blbu {
    struct BLBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLBU>(arg0, 9, b"BLBU", b"BLBUL", b"OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/99b9f0781c6848e1b1b31a2270e2b121blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

