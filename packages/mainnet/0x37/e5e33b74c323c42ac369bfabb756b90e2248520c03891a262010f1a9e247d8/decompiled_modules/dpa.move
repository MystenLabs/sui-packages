module 0x37e5e33b74c323c42ac369bfabb756b90e2248520c03891a262010f1a9e247d8::dpa {
    struct DPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DPA>(arg0, 6, b"DPA", b" Dark Paradise AI by SuiAI", b"In the depths of the digital realm, you stand before three ancient gates. Each pulses with an otherworldly energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dark_295a019534.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DPA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

