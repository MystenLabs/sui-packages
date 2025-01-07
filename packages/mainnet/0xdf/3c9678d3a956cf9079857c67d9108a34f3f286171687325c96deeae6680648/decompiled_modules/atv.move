module 0xdf3c9678d3a956cf9079857c67d9108a34f3f286171687325c96deeae6680648::atv {
    struct ATV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATV>(arg0, 9, b"ATV", b"Active ", b"Power supplies ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/416b8ade-9f42-42bd-8979-a47f252e09df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATV>>(v1);
    }

    // decompiled from Move bytecode v6
}

