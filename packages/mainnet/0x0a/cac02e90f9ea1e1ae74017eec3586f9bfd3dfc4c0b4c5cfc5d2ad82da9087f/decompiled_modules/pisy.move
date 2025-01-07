module 0xacac02e90f9ea1e1ae74017eec3586f9bfd3dfc4c0b4c5cfc5d2ad82da9087f::pisy {
    struct PISY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISY>(arg0, 9, b"PISY", b"Pisylig", x"4974e2809973206a7573742061206361742077686f206c6f76657320736c656570", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6d4c7cc-54da-42ff-979a-bb30980ca5ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PISY>>(v1);
    }

    // decompiled from Move bytecode v6
}

