module 0x7309d24bf88e1f41fd7ce6a93380e471103833a54cfb8d830fd5a58bc6761ccb::snp {
    struct SNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNP>(arg0, 9, b"SNP", b"$noop", b"Snoopin' Around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3df620a6-ee24-47d9-85b9-2774a76e3f95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNP>>(v1);
    }

    // decompiled from Move bytecode v6
}

