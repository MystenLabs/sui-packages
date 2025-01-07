module 0x9b88cf16754eedf41000ae186f3038da4277f223958320ea28970120511288a7::emp {
    struct EMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMP>(arg0, 9, b"EMP", b"Emperors", b"Emperors!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8939661-7dee-4270-9217-2588b5be87cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

