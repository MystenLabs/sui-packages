module 0x1fabdb964836e86f004ee96a007ffc290a1cb8d58b9eec2b6f340e8b842ae852::nbrgr {
    struct NBRGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBRGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBRGR>(arg0, 6, b"NBRGR", b"Nothing Burger", x"4e6f7468696e672042757267657220697320612066756e2070726f6a6563742061626f7574206e6f7468696e672c206974e2809973206f6e6c7920676f616c2061732061206d656d6520636f696e20697320746f2068656c70206665656420697473207573657273207769746820746f6b656e7320616e6420636f6c6c65637469626c65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748132301321.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBRGR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBRGR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

