module 0x4f2eb737bbdd9453533101f7032ae757e723b4490f2e36c0409897f3215c33e3::trumpelon {
    struct TRUMPELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPELON>(arg0, 9, b"TRUMPELON", b"Trumpelon", b"Both is to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb46536e-cf68-4e8b-b75b-200b14a6416f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

