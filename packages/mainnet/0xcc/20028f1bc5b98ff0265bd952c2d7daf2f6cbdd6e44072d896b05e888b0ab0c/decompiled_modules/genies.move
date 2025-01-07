module 0xcc20028f1bc5b98ff0265bd952c2d7daf2f6cbdd6e44072d896b05e888b0ab0c::genies {
    struct GENIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENIES>(arg0, 6, b"Genies", b"Genies On Sui", b"The Genies is here to grant your wildest crypto wishes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2bc2170557.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

