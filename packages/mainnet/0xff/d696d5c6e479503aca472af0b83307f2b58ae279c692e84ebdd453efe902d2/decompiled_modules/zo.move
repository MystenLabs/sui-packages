module 0xffd696d5c6e479503aca472af0b83307f2b58ae279c692e84ebdd453efe902d2::zo {
    struct ZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZO>(arg0, 6, b"ZO", b"zero", b"Believe that all tokens will eventually go to zero.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_00b1b5bf6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

