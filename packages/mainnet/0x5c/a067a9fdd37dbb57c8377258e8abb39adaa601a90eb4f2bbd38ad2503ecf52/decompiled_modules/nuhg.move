module 0x5ca067a9fdd37dbb57c8377258e8abb39adaa601a90eb4f2bbd38ad2503ecf52::nuhg {
    struct NUHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUHG>(arg0, 6, b"NUHG", b"NUHGS", b"No rules, just $NUHG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NUHG_6d1bda5a9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

