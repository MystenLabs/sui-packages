module 0xf0fc2a2230d11a3a3601e33eef50f82dfc07c6df77a7df8bf0392ebac9ac8b5::paki {
    struct PAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAKI>(arg0, 9, b"paki", b"paki", b"islaman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

