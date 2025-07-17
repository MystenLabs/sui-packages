module 0xbd68c87b03d9f473f2fb5b774a371dd4c8d00b540dc8b7ffcdcc53be14160b92::prc {
    struct PRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRC>(arg0, 6, b"PRC", b"PRICE", b"For u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidficivfar3cferwbwqz64qz36nxtmhl7vtplujdwnrikx64iau7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PRC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

