module 0xf6507041ac54a7c832501444b6499b8fc6d6a4b7ff73abfd35ef9a308b3e5168::dudes {
    struct DUDES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUDES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUDES>(arg0, 6, b"DUDES", b"Wednesday, my dudes", x"446f6ee280997420666f7267657420746f207769736820796f75722064756465732061206861707079205765646e65736461792c2062726f2e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749641886817.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUDES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUDES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

