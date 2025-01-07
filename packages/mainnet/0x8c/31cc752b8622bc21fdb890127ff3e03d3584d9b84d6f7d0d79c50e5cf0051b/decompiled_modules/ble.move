module 0x8c31cc752b8622bc21fdb890127ff3e03d3584d9b84d6f7d0d79c50e5cf0051b::ble {
    struct BLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLE>(arg0, 9, b"BLE", b"Beetle ", b"It a nice coin very potential ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1738d7b6-dcca-4d50-aad2-c795c61cb446.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

