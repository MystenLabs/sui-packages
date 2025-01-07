module 0x358fe1f30a1c560c7167d354d5ca4eca11ea362be80d517ac78441a6dc0f6ce9::suzi {
    struct SUZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZI>(arg0, 6, b"SUZI", b"Suizi", b"You are Suizi, you don't event read bios  but if you do $SUZI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016435_3674e0b3be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

