module 0xc4c6b9404ab21eea9f043da9332065ce4de66cfd52e31d98746cb7bbb0554dc5::latte {
    struct LATTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LATTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LATTE>(arg0, 6, b"LATTE", b"LATTEonSUI", x"456e6a6f79207468650a7269646520776974680a244c415454450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_KII_Acc_G_400x400_b285d0c7f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LATTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LATTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

