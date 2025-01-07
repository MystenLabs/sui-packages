module 0x71f9193793d0a8ff8bb854a57b4466dde354146bafe21eec7de3caf1521d4eb3::rtrump {
    struct RTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTRUMP>(arg0, 9, b"RTRUMP", b"Royaltrump", b"Trump is him ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f455c1a-c27d-4713-a59b-d6a2c0549f1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

