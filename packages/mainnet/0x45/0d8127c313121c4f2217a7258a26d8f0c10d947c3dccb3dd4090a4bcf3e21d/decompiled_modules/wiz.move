module 0x450d8127c313121c4f2217a7258a26d8f0c10d947c3dccb3dd4090a4bcf3e21d::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZ>(arg0, 6, b"WIZ", b"Wizard Land", b"What is Magic Land is a new work from Wizard Land that focuses on original works of art on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731450912411.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

