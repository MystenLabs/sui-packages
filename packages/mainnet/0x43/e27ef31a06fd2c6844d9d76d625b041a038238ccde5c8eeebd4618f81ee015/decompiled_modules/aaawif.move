module 0x43e27ef31a06fd2c6844d9d76d625b041a038238ccde5c8eeebd4618f81ee015::aaawif {
    struct AAAWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAWIF>(arg0, 6, b"aaaWIF", b"aaa Cat Wif HAt", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adssssssssssssss_a97caa74c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

