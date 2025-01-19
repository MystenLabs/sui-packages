module 0x237178299b5003ddf04d61435f273e03d1c0f02b951c97c23de59a3f166bda20::cmm {
    struct CMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMM>(arg0, 9, b"CMM", b"VcVcVc", b"Fuck you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b7f6fac-63c4-4acd-aca9-3d7f09eecb8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

