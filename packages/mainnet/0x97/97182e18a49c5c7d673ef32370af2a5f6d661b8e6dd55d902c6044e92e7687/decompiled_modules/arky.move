module 0x9797182e18a49c5c7d673ef32370af2a5f6d661b8e6dd55d902c6044e92e7687::arky {
    struct ARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARKY>(arg0, 6, b"ARKY", b"ARKYCOIN", b"ARKY IS NAME OF DOGS FROM SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9727eaf447203be268e5d471b6503bf47a71ea72_932d76d7b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

