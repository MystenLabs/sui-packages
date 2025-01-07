module 0x8672dce75ff1e4a75866c38692313fb172c0e0ac5b3d5560aa095138a75c664a::suiiiiiiiiii {
    struct SUIIIIIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIIIIIII>(arg0, 6, b"Suiiiiiiiiii", b"CR7", x"4e6f206465762c20692074616b65206f6e6c7920322520737570706c792e0a0a596f752043616e20637265617465642074672067726f757020696620796f752077616e742e0a0a4a75737420666f722066756e0a0a53756969696969696969690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062161_21b3bb7810.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIIIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

