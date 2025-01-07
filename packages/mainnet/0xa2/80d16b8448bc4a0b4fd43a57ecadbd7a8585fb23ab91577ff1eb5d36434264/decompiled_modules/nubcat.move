module 0xa280d16b8448bc4a0b4fd43a57ecadbd7a8585fb23ab91577ff1eb5d36434264::nubcat {
    struct NUBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUBCAT>(arg0, 6, b"NUBCAT", b"Nub Cat", b"nub is a silly cat for the silliest of goobers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_1_b94c9262f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

