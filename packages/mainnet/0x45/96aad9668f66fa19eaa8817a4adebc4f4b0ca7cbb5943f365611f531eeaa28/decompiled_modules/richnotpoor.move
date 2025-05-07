module 0x4596aad9668f66fa19eaa8817a4adebc4f4b0ca7cbb5943f365611f531eeaa28::richnotpoor {
    struct RICHNOTPOOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHNOTPOOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHNOTPOOR>(arg0, 6, b"Richnotpoor", b"Rich", b"Rich not poor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejdr4w2lww33l7si6gja7egplcpyc6cwnwwii4xvsrb7s76iw7ni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHNOTPOOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RICHNOTPOOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

