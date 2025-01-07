module 0x2d52e91ec3fd7f5794182d6d8c5986861bed7a1eab9c7b53a149f039a2dff7ba::btc100k {
    struct BTC100K has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC100K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC100K>(arg0, 6, b"BTC100K", b"Bitcoin100K", b"BTC: The OG of crypto, now laser-eyed and geared for 100k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732197244141.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC100K>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC100K>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

