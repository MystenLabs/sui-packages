module 0xf3b44e3057a2fef794fb7fc4e05ae277077dc6a0f574d6a566e3b1d1783e96f6::trumplon {
    struct TRUMPLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLON>(arg0, 9, b"TRUMPLON", b"Trump Elon", b"This tokeb support Trump n Elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfce08dd-3f93-493a-aa3c-d032042b936d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

