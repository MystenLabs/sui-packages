module 0x62b2fa9e4db5071708250600d9ce0f41c3b212f5808d283ec50bf08dd5fc66f::nikz {
    struct NIKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKZ>(arg0, 9, b"NIKZ", b"Nikzo", b"Lone Wolf ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/695d1f78-a973-4b23-9674-f51d270c447d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

