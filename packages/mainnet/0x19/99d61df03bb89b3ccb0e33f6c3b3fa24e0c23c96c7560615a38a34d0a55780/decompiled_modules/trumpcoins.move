module 0x1999d61df03bb89b3ccb0e33f6c3b3fa24e0c23c96c7560615a38a34d0a55780::trumpcoins {
    struct TRUMPCOINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPCOINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPCOINS>(arg0, 6, b"TRUMPCOINS", b"Trump commemorative coins", b"This beautiful limited edition commemorative coin celebrates our movement, our struggle for freedom and prosperity, and our continued commitment to putting America First", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d03d4ac633ff010f45cc700fade58847_972d1dccea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPCOINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPCOINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

