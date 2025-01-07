module 0xb999ed69f6c5e5c98d6c06c9a1471a521154383fa6be1d5ae37c38b17fa25aa6::btc100k {
    struct BTC100K has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC100K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC100K>(arg0, 6, b"BTC100K", b"Bitcoin 100K", b"LFG Bitcoin hit 100k$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731517231148.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC100K>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC100K>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

