module 0xf457dc0d98cdb8c04aa5bc11e8c65307439890be4babd79133687c6208ad6a0c::alphasui {
    struct ALPHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHASUI>(arg0, 6, b"AlphaSui", b"Alpha 4 SUI", b"Born by water on sui,And will give blessing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicvao55wpu4fcxegpjatszok2ofzdivlqps2pl3jkkc424ghyqstu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

