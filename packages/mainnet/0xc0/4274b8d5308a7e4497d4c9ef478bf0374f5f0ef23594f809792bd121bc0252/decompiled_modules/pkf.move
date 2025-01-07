module 0xc04274b8d5308a7e4497d4c9ef478bf0374f5f0ef23594f809792bd121bc0252::pkf {
    struct PKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKF>(arg0, 9, b"PKF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/838dba06-d2f3-430d-b113-d915139965f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

