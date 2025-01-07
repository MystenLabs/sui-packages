module 0x2044a8452026ae51550bbd7246cf85e58c09dc258ab26d022a5305e126e9b02c::cupcat {
    struct CUPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPCAT>(arg0, 6, b"CUPCAT", b"Cupcat", b"A cat in a cup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731813015882.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

