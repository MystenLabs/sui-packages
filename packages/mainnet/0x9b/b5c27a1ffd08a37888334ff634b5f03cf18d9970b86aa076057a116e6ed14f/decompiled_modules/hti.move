module 0x9bb5c27a1ffd08a37888334ff634b5f03cf18d9970b86aa076057a116e6ed14f::hti {
    struct HTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTI>(arg0, 6, b"HTI", b"HATSUI", b"THE HAT SUI NEEDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hat_b6393fff3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

