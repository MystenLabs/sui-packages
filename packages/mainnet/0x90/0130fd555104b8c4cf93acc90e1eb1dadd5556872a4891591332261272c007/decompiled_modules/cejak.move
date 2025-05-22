module 0x900130fd555104b8c4cf93acc90e1eb1dadd5556872a4891591332261272c007::cejak {
    struct CEJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEJAK>(arg0, 6, b"CEJAK", b"Cejak ", b"Cetus got hacked. We're all cooked, including Cejak. His life savings are gone. His last chance to make it out is through $CEJAK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747924652073.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEJAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEJAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

