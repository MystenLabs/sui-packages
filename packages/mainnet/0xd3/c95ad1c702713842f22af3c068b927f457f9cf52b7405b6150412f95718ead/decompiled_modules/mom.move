module 0xd3c95ad1c702713842f22af3c068b927f457f9cf52b7405b6150412f95718ead::mom {
    struct MOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOM>(arg0, 9, b"MOM", b"Momcoin ", b"This token is all about love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f061fb1-6206-422b-91e5-0f41a283291d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

