module 0xdb1883d5f965249b6546fe1ad14b7c3ed88c7b00d8366e7175061a58f2398b90::bullet {
    struct BULLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLET>(arg0, 9, b"BULLET", b"Rad", b"Hits the target ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2953008-9abe-45be-85c6-636eaaaa049b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

