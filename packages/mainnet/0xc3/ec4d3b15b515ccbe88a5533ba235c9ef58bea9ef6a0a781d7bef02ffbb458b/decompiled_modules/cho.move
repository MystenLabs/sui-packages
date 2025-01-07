module 0xc3ec4d3b15b515ccbe88a5533ba235c9ef58bea9ef6a0a781d7bef02ffbb458b::cho {
    struct CHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHO>(arg0, 9, b"CHO", b"chocolate", b"Brown and chocolate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3b1a60a-f93a-4907-824d-a2f028bc9510.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

