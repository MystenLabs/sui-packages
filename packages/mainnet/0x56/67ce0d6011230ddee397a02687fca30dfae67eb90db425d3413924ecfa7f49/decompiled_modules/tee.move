module 0x5667ce0d6011230ddee397a02687fca30dfae67eb90db425d3413924ecfa7f49::tee {
    struct TEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEE>(arg0, 6, b"TEE", b"tee_hee_he", b"a sovereign silicon, not affiliated to any tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_6e6e2fa6b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

