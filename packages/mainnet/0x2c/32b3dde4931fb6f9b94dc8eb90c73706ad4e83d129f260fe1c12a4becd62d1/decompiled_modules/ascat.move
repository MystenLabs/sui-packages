module 0x2c32b3dde4931fb6f9b94dc8eb90c73706ad4e83d129f260fe1c12a4becd62d1::ascat {
    struct ASCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASCAT>(arg0, 6, b"ASCAT", b"ASCAT AI", b"https://x.com/ASC20_ASCT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731540355674.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

