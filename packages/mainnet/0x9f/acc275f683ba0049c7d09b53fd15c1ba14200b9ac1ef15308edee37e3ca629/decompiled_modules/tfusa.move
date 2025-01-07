module 0x9facc275f683ba0049c7d09b53fd15c1ba14200b9ac1ef15308edee37e3ca629::tfusa {
    struct TFUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFUSA>(arg0, 9, b"TFUSA", b"TrumpForUSA", b"Trump for the president !!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TFUSA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFUSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TFUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

