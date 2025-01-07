module 0x3158f2f82005bf29b6c51eb5740991f02de68cd4239a683fc490652f00a41c46::wtrump {
    struct WTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTRUMP>(arg0, 6, b"WTRUMP", b"Winner Trump", b"Vision meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022101_da02f6c676.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

