module 0x66ef9c1ab4f0574ce408fd3d15e3541cbc31b01ba4f01ca10d10fbb9d0bc84a8::sngku {
    struct SNGKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNGKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNGKU>(arg0, 9, b"SNGKU", b"Son Goku", b"Son Goku coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNGKU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNGKU>>(v2, @0xfaaa3625fad4f10e96de779bfb8cb369a8c699f11725244ba4c3670c31bc0492);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNGKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

