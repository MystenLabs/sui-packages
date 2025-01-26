module 0xf0b24cea392c6f39a01dd96bd0e35d24401bc933e00d6b4b402b7c993df66e6c::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 6, b"TOM", b"Tom and jerry", b"Tom and jerry abcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_fdd008c31c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

