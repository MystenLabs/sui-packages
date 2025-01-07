module 0xd0638e37f4c85b70bf28442d0b6c557b98377e21e3e37b7b81545d8cd8c227ba::roy {
    struct ROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROY>(arg0, 9, b"ROY", b"Rion", b"Dhsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c49b553-2972-4171-a33e-2cdbeb965cd1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROY>>(v1);
    }

    // decompiled from Move bytecode v6
}

