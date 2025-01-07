module 0xeacb7d73bfd8428397c7f93c6594437a310ff94d7c7ca1752ecfbafac7fe9ccc::str {
    struct STR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STR>(arg0, 9, b"STR", b"Shooter", b"Shooter coin for all the Shooters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7306a5db-a0ce-4ce1-84a3-e3cb1909ded7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STR>>(v1);
    }

    // decompiled from Move bytecode v6
}

