module 0xf5cd0059694bad3e7b0d8c3685b985c5bf4b59f70004b799e52f8ece3f45d6dc::anc {
    struct ANC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANC>(arg0, 9, b"ANC", b"Airdrop New Channel", b"Airdrop New Channel Telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5f1a83ff256b36231943087f92532597blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

