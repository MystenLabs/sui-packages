module 0x81dbc5e89261e7df08090d61906f8e15bbc444eadc2c3cd87019765bae3bdbaa::wetask {
    struct WETASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETASK>(arg0, 9, b"WETASK", b"WEWE task", b"This is for a task lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36723588-d5c0-4125-94d9-179d60cb8a06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

