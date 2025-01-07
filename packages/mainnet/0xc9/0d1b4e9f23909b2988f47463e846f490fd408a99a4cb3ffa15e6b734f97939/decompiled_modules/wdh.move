module 0xc90d1b4e9f23909b2988f47463e846f490fd408a99a4cb3ffa15e6b734f97939::wdh {
    struct WDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDH>(arg0, 9, b"WDH", b"wooden hut", b"For originality", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b827943c-151e-46b9-8473-19cb674f504f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

