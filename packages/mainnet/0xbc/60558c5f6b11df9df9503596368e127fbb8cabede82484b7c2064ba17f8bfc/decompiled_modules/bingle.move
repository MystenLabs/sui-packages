module 0xbc60558c5f6b11df9df9503596368e127fbb8cabede82484b7c2064ba17f8bfc::bingle {
    struct BINGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINGLE>(arg0, 6, b"Bingle", b"Bingle Coin", b"\"Bingle, is a low velocity, highly unstable isotopic crypto-token made to inspire the downtrodden masses to acquire their digital ascension to 'not being broke' there will likely not be any rugpulls in the forseeable future unless this exceeds $5tril", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740073711917.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINGLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINGLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

