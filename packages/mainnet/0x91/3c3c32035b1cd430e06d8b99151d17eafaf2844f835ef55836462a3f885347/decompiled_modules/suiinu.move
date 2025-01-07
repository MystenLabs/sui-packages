module 0x913c3c32035b1cd430e06d8b99151d17eafaf2844f835ef55836462a3f885347::suiinu {
    struct SUIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINU>(arg0, 6, b"SUIINU", b"sui inu", x"23535549203d205761746572202b20496e75203d20446f670a0a53756920496e752069732074686520576174657220446f67206f66205375692e0a0a4d616b696e6720686973746f72792c20666f6c6c6f7720583a2068747470733a2f2f782e636f6d2f73756973696e75", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K3_HE_Jo_X5_400x400_a5b1a951be_bf489bb6c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

