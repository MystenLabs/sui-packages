module 0xf9f120a92e137e16948baf5e33124a0094f2e71d0c61f574e0659f6cba228c03::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCAT>(arg0, 9, b"POPCAT", b" Popcat", x"446561642077616c6c6574732c2070756d7020616e642064756d70732c207275672070756c6c732e2e2e20546865206d61726b65742063616e207365656d206c6966656c6573732061742074696d65732e204275792066656172206e6f742c207765277665206265656e207468657265206265666f72652e0a0a4e6f7720697427732074696d6520746f207361766520746865206d61726b65742c20616e6420646f6e2774206d6973732024504f50434154", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9cc1c66a-d48b-40f1-a06f-db2206281668.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

