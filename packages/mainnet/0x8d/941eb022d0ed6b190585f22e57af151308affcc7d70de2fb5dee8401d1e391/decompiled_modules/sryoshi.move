module 0x8d941eb022d0ed6b190585f22e57af151308affcc7d70de2fb5dee8401d1e391::sryoshi {
    struct SRYOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRYOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRYOSHI>(arg0, 6, b"SRYOSHI", b"Sui Ryoshi", x"5375692052796f736869206a7573742064726f70706564206f6e205355492c20616e642069742773206c697421205468697320746f6b656e277320676f7420746865207669626573206f662061206368696c6c2073756e7269736520616e642074686520776973646f6d206f6620736f6d6520616e6369656e74206d61737465722c20616c6c20726f6c6c656420696e746f206f6e652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953352760.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRYOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRYOSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

