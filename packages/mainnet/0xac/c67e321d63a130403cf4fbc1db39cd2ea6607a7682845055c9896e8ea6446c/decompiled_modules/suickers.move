module 0xacc67e321d63a130403cf4fbc1db39cd2ea6607a7682845055c9896e8ea6446c::suickers {
    struct SUICKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICKERS>(arg0, 6, b"SUICKERS", b"The First Snack on SUI", b"The first snack on @suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suickers_Logo_753bbc2260.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

