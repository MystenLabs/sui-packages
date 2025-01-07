module 0x19d06b1776045628c5f17df838ca1a6427461c0a6a9a51f5e8e51a09d2d40535::ait {
    struct AIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIT>(arg0, 9, b"AIT", b"Aitrader", b"Ai trader in the all market ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2c04d36-9239-4235-92a1-b033118c316c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

