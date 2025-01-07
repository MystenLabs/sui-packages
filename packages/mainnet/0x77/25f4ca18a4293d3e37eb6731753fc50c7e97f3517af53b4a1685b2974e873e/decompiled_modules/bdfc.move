module 0x7725f4ca18a4293d3e37eb6731753fc50c7e97f3517af53b4a1685b2974e873e::bdfc {
    struct BDFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDFC>(arg0, 9, b"BDFC", b"Binh Dinh", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32e7ca87-a89e-4211-8996-d4ab9ee8aab7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

