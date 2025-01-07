module 0xf73ab01498bf19449c0a31ddf952f2181f9b97354998e145bc8287264fd0c423::spd {
    struct SPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPD>(arg0, 6, b"SPD", b"SUIPET", b"A PET BY SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6830_61a3637e51.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

