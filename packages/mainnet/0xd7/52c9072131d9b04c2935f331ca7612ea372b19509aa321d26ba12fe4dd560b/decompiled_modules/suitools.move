module 0xd752c9072131d9b04c2935f331ca7612ea372b19509aa321d26ba12fe4dd560b::suitools {
    struct SUITOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOOLS>(arg0, 6, b"SUITOOLS", b"SuiTools", x"46697273742073756920636861696e207375697363616e6e657220626f74206973206c697665200a405375695f5363616e6e65725f426f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028974_64cf101c40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

