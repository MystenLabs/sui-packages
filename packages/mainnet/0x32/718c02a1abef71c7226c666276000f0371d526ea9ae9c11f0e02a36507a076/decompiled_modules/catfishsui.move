module 0x32718c02a1abef71c7226c666276000f0371d526ea9ae9c11f0e02a36507a076::catfishsui {
    struct CATFISHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISHSUI>(arg0, 6, b"CATFISHSUI", b"CAT FISH SUI", b"THE NAME IS $CATFISHSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicatfish_2f70fb8b0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFISHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

