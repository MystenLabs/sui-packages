module 0x9bc29490545b7939e1a2bc3d0c8303e84163b49ac9e928673acdfde89f06b0c0::afish {
    struct AFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFISH>(arg0, 6, b"AFISH", b"Angry fish", b"dont buy,just look", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_152317_f62fad14e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

