module 0x59abb4de8348964cc00dc746cb04a05e3c568013548aa4d2bd2261608505f1c7::piggy {
    struct PIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGGY>(arg0, 9, b"PIGGY", b"Trust pig", x"596f752063616e207472757374206d652e2049e280996c6c206d616b6520796f752062696c6c696f6e6169726520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c2c7105-4079-447c-a783-99b2e6da5aea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

