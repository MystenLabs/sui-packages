module 0xacb283d7f70e39365f4d9c3735a67db25d73e0769f39311d377536565a6c85b::trumplon {
    struct TRUMPLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLON>(arg0, 9, b"TRUMPLON", b"Trump Elon", b"This tokeb support Trump n Elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce494003-9ff4-47fc-a4ba-81a703429487.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

