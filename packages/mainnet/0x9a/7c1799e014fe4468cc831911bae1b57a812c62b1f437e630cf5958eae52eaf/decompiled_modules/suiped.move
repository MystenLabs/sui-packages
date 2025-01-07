module 0x9a7c1799e014fe4468cc831911bae1b57a812c62b1f437e630cf5958eae52eaf::suiped {
    struct SUIPED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPED>(arg0, 6, b"SUIPED", b"BLUE SUI APED", b"This ape is smart, this ape aped $SUIPED ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3775_c201787356.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPED>>(v1);
    }

    // decompiled from Move bytecode v6
}

