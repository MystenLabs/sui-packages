module 0x333cc1c0e62e93c8c4d6d57afa1afeb54e481ddd5ac0b74d080ba184f401f91::atu {
    struct ATU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATU>(arg0, 9, b"ATU", b"Autum", b"Autumntale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd915ab9-3503-4934-bcf5-7efe1145117d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATU>>(v1);
    }

    // decompiled from Move bytecode v6
}

