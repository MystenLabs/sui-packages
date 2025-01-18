module 0xb63b30615926f6e83f64178f45adc9e4f2e13ea66b8f79183fa300914d7dd3c6::trump2 {
    struct TRUMP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP2>(arg0, 6, b"Trump2", b"trump2", b"donald trump fan meme token half of the tokens will be distributed as airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737231000924.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

