module 0x2ed8e826fff02d75fb7f4716b4ffc69290e0580a1c428d0b3dd35b79fa683716::octopusui {
    struct OCTOPUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOPUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOPUSUI>(arg0, 6, b"Octopusui", b"OctopuSUI - Aliens", x"536369656e6365206469637461746573207468617420746865206d7973746572696f757320616e6420696e74656c6c6967656e74204f63746f707573207761732062726f7567687420746f206561727468206f6e2061206d6574656f726974652e2020416c69656e20636f2d696e68616269746f7273206f66206f757220776f726c642e200a4f63746f7075535549207761732062726f7567687420746f2053554920627920616e6f7468657220667269656e646c7920616c69656e20737065636965732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736211383548.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTOPUSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOPUSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

