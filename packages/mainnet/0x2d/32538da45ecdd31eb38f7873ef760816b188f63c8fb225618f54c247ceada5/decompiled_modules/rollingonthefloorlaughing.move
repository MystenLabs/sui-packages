module 0x2d32538da45ecdd31eb38f7873ef760816b188f63c8fb225618f54c247ceada5::rollingonthefloorlaughing {
    struct ROLLINGONTHEFLOORLAUGHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROLLINGONTHEFLOORLAUGHING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROLLINGONTHEFLOORLAUGHING>(arg0, 6, b"ROLLINGONTHEFLOORLAUGHING", b"ROLLING ON THE FLOOR LAUGHING", b"SuiEmoji Rolling on the Floor Laughing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiemoji.fun/emojis/rollingonthefloorlaughing.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROLLINGONTHEFLOORLAUGHING>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROLLINGONTHEFLOORLAUGHING>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

