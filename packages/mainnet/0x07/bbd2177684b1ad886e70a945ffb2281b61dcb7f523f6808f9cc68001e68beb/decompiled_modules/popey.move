module 0x7bbd2177684b1ad886e70a945ffb2281b61dcb7f523f6808f9cc68001e68beb::popey {
    struct POPEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEY>(arg0, 6, b"POPEY", b"POPEY SUI", b"The next memecoin season ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241010_183527_eb005475ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

