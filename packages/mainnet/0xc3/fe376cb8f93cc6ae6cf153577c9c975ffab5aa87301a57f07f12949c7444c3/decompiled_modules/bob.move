module 0xc3fe376cb8f93cc6ae6cf153577c9c975ffab5aa87301a57f07f12949c7444c3::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"BOB SPONGE", x"412066756e20616e642065786f7469632063757272656e6379206d6164652066726f6d2065766572796f6e652773206661766f72697465207365612073706f6e67650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d379104-e355-48f0-b649-3089a11be651.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

