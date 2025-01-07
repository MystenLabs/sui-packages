module 0x9e5e4b0a40f2930b2b065956732a1ddc5d876f7db49cf1226c59598e987a0cb::bony {
    struct BONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONY>(arg0, 6, b"BONY", b"Bonydog Sui", b"$BONY IS THE CUTEST ANIMAL ON SUI, ON A MISSION TO BE THE GREATEST DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001300_46da3000c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

