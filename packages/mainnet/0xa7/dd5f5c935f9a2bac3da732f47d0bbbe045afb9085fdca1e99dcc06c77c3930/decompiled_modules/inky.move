module 0xa7dd5f5c935f9a2bac3da732f47d0bbbe045afb9085fdca1e99dcc06c77c3930::inky {
    struct INKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: INKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INKY>(arg0, 6, b"INKY", b"Inky Cat", b"The Inkiest Cat On Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/inky_4781577bdd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

