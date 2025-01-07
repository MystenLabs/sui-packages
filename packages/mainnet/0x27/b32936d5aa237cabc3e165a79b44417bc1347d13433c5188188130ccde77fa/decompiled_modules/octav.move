module 0x27b32936d5aa237cabc3e165a79b44417bc1347d13433c5188188130ccde77fa::octav {
    struct OCTAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTAV>(arg0, 6, b"OCTAV", b"Octav", b"Octav is an octopus populating the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Octav_5cee62f612.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

