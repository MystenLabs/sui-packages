module 0x79c22b896649d2760aff35cca9eb02371416e93f4e317934572cefbc31c2088e::gorillaz {
    struct GORILLAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORILLAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORILLAZ>(arg0, 6, b"GORILLAZ", b"Gorillaz Sui", b"Were Gorillaz. Yeah, those Gorillaz. The worlds most iconic animated band.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_YRYC_Pd_I_400x400_6a2de88de2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORILLAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORILLAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

