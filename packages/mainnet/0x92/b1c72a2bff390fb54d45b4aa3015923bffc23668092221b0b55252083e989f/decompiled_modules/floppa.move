module 0x92b1c72a2bff390fb54d45b4aa3015923bffc23668092221b0b55252083e989f::floppa {
    struct FLOPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPA>(arg0, 6, b"FLOPPA", b"Floppa", b"Just a caracal with floppy ears", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Tavr_C7o_400x400_335e1120a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

