module 0xffc6975fe12445e8a7730ba2533f2b173d61f1d152c58c2923477b2df43e6773::pchy {
    struct PCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCHY>(arg0, 6, b"PCHY", b"Peach Milk", b"Say hello to the NEW Peach Milk ($PCHY - the ultimate token that brings the vibes and energy of EUPHORIA straight to the SUI blockchain! Dev is bringing back the SWEETNESS everyone in a more fair, controlled way (without the bad peeps!). Pick up a glass!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mx4_Eo_G4w_400x400_5b7fcf956b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

