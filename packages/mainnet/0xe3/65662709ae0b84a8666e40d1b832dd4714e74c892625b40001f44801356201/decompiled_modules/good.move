module 0xe365662709ae0b84a8666e40d1b832dd4714e74c892625b40001f44801356201::good {
    struct GOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD>(arg0, 6, b"GOOD", b"Sui Good", x"576527726520617765736f6d652c206172656e27742077653f200a4a6f696e20757320696e2074776f20737465703a20436865636b20434120696e2054472c207468616e20686f6c642e2020202020202020202020742e6d652f5355495f474f4f44", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_c2b00b450d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

