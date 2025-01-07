module 0xa2661abe2315244e527c197ea84a36d6d50457a754cdd41f11f785683de39183::izzy {
    struct IZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZY>(arg0, 6, b"IZZY", b"IZZY Matt Furie's Dog On Sui", b"Izzy, the Golden Retriever of Matt Furie, creator of Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_153639_c91234a7f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

