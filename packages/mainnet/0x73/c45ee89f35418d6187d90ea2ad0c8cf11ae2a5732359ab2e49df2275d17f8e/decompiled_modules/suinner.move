module 0x73c45ee89f35418d6187d90ea2ad0c8cf11ae2a5732359ab2e49df2275d17f8e::suinner {
    struct SUINNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINNER>(arg0, 6, b"Suinner", b"SUINNERSUI", b"The combination of MovePump and Sui into a fidget spinner creates a highly powerful community that is always in motion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_094132_193_f6bad2cfcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

