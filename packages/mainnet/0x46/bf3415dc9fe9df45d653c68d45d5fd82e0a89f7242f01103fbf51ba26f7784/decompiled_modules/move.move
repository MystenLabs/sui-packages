module 0x46bf3415dc9fe9df45d653c68d45d5fd82e0a89f7242f01103fbf51ba26f7784::move {
    struct MOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE>(arg0, 6, b"MOVE", b"MovePump", b"MOVE TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4444_66659b504e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

