module 0x4d0fb11b89db8b3520fd00e22a5007e39dc57464799c29e80a3ae0f598e60598::le_coin {
    struct LE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE_COIN>(arg0, 9, b"LC1", b"le coin", b"{\"description\":\"it works\",\"twitter\":\"https://twitter.com/it\",\"website\":\"https://google.com\",\"telegram\":\"https://t.me/groupname\",\"tags\":[\"one\",\"two\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/7344b8c2-1a62-4925-9957-76167e30de10.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

