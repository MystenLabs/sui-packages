module 0xdfa379492bfce1de16a033b3bc80c8c1da28210ab6bc871cd4169c023d2c42a3::mtai {
    struct MTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTAI>(arg0, 9, b"MTAI", b"Meta AI", b"This is a feature for AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/71f49325-cf71-4e68-bf61-b464fb96e3fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

