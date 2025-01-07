module 0x91703089713cbff4489925c9b884edd959880ae9462a3b52ac0979cf8964df11::nonom {
    struct NONOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONOM>(arg0, 6, b"Nonom", b"Tiny dancer", b"Let's go to the Moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056368_cd4d064f4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

