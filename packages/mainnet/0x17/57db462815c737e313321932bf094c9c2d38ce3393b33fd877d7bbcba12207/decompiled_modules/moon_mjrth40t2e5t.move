module 0x1757db462815c737e313321932bf094c9c2d38ce3393b33fd877d7bbcba12207::moon_mjrth40t2e5t {
    struct MOON_MJRTH40T2E5T has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON_MJRTH40T2E5T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON_MJRTH40T2E5T>(arg0, 9, b"MOON", b"SUI", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmU8qazhpfyZVjp5U3bag5NgVUfUdPMSw1iptCCR5a4rm7")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON_MJRTH40T2E5T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON_MJRTH40T2E5T>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

