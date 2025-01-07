module 0x97c832771f2b4d8dfcbb8c01820b3aa5addcdd44c9a7790fd7a240e173abdc62::fupe {
    struct FUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUPE>(arg0, 6, b"FUPe", b"FUPengiun", b"Pengiuns takeover! But not the cuddly kind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FU_Penguin_Clean_97eed886de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

