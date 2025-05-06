module 0x9d329966d0e5f9464a40bb13c1ede92e6ef2b19a2e0ac039a057934343774118::DAWG {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"DAWG", b"chill dawg", b"ahh yee ahh yee ahhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmRTZ7djhVgnS3cvjxuNiSwwuP6sPvk3rw7iYCCCuVDDEB")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

