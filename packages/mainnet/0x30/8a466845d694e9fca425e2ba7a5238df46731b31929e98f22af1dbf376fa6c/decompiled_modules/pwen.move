module 0x308a466845d694e9fca425e2ba7a5238df46731b31929e98f22af1dbf376fa6c::pwen {
    struct PWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWEN>(arg0, 6, b"PWEN", b"Sui Pwen", b"Meet PWEN, the penguin of Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PWEN_908cb5e7cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

