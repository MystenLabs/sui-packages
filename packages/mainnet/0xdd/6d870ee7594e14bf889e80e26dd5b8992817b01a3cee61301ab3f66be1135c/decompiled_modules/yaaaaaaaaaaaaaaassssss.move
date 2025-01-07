module 0xdd6d870ee7594e14bf889e80e26dd5b8992817b01a3cee61301ab3f66be1135c::yaaaaaaaaaaaaaaassssss {
    struct YAAAAAAAAAAAAAAASSSSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAAAAAAAAAAAAAAASSSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAAAAAAAAAAAAAAASSSSSS>(arg0, 6, b"Yaaaaaaaaaaaaaaassssss", b"Yas on Sui", b"Culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GQR_1n_S_Wk_A_Aj_X_Qn_4a434bf0dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAAAAAAAAAAAAAAASSSSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAAAAAAAAAAAAAAASSSSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

