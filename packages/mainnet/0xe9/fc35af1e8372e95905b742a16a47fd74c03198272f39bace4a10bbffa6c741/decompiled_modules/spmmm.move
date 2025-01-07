module 0xe9fc35af1e8372e95905b742a16a47fd74c03198272f39bace4a10bbffa6c741::spmmm {
    struct SPMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPMMM>(arg0, 6, b"SPMMM", b"MMM Global", b"It's more expensive today than yesterday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_ad5001109b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPMMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPMMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

