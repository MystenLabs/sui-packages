module 0x9b356b0b44f80633175254b7d72b7216883057fb140f422181697a4af43df7f::mhd {
    struct MHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHD>(arg0, 6, b"MHD", b"Musk have Dolphin", b"We Musk have Dolphin!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5879_6eb18b2849.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

