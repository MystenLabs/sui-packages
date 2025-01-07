module 0x7432efe952ad96e5b6ab317d109874423823ffa80d1b9202957da4662fcd64d4::spdcoin {
    struct SPDCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPDCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPDCOIN>(arg0, 9, b"SPDCOIN", b"SpiderM", b"Spiderman trading coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ff7eabd-dca6-4247-9917-9497e3252bbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPDCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPDCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

