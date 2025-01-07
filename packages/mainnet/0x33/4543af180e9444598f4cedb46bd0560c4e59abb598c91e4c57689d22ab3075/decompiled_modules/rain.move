module 0x334543af180e9444598f4cedb46bd0560c4e59abb598c91e4c57689d22ab3075::rain {
    struct RAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIN>(arg0, 9, b"RAIN", b"Raindrop", b"rain not drain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f18ea509-94b9-4190-8c0c-1696d7de556e-1000212697.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

