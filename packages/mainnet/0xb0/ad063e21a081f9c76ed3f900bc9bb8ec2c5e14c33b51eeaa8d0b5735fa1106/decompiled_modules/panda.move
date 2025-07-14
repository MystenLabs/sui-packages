module 0xb0ad063e21a081f9c76ed3f900bc9bb8ec2c5e14c33b51eeaa8d0b5735fa1106::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"Panda", b"panda", b"it's fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752463887181.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

