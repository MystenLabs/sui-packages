module 0x935d74237b2a9ac8ae5a2e36acf95ab65c78caf41c2f2cd6c049c9dbff2f6779::vxcf {
    struct VXCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: VXCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VXCF>(arg0, 9, b"VXCF", b"VXC", b"VXCB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7aab9ae-ef26-4ec9-950f-e9571b32ab91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VXCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VXCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

