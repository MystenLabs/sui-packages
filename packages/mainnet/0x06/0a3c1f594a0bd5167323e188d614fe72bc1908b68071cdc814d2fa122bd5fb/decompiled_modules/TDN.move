module 0x60a3c1f594a0bd5167323e188d614fe72bc1908b68071cdc814d2fa122bd5fb::TDN {
    struct TDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDN>(arg0, 6, b"TDN", b"Tariff deez nuts", b"Wahoo Yipee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmQqim4mUoWsauZHZyXEj95hXXkRub6E3aSqgEGX3PxsKN")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

