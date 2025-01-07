module 0x74705d08662ccc41b50f134961ef9e5b4ff7c752a5016760f00611e3a68c8d2a::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Peanut  The Squirrel", b"Beloved Peanut the Squirrel was taken away from his home by NYSDEC and euthanized. The seven year old rescued squirrel represented PNuts Family Freedom Farm Animal Sanctuary an organization devoted to rescuing and rehabilitating injured and abandoned animals. He may no longer walk amongst us but he lives on forever. Peanut forever. Peanut comes on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEANUT_0ea0d76ff1.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

