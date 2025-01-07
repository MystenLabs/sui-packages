module 0x3596ee5b445fc50e150863cf19f2171989833b33f5d72e1f1dd55a79ab9bc425::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 6, b"MUMU", b"Mumu the Bull", b"Mumu comes to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cy4_Al_P30_400x400_ae16bcc14f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

