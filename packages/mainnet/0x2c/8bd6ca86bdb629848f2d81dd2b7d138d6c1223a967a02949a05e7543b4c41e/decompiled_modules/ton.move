module 0x2c8bd6ca86bdb629848f2d81dd2b7d138d6c1223a967a02949a05e7543b4c41e::ton {
    struct TON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TON>(arg0, 9, b"TON", b"tonn", b"TONN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58e0b694-3cba-46ea-8942-d5aeaf18f621.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TON>>(v1);
    }

    // decompiled from Move bytecode v6
}

