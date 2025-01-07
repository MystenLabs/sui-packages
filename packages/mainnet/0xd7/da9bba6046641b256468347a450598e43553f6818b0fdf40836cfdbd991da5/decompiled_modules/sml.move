module 0xd7da9bba6046641b256468347a450598e43553f6818b0fdf40836cfdbd991da5::sml {
    struct SML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SML>(arg0, 9, b"SML", b"smile", x"427269676874656e20796f757220646179207769746820536d696c65436f696e20f09f988af09f988af09f988af09f988a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67bc1c5a-550c-46be-bc97-cc3b901288a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SML>>(v1);
    }

    // decompiled from Move bytecode v6
}

