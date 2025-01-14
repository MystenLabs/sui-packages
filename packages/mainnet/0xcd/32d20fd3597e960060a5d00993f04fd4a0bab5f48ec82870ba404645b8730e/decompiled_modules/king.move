module 0xcd32d20fd3597e960060a5d00993f04fd4a0bab5f48ec82870ba404645b8730e::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"king", b"This is test.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tron_f364a22774.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KING>>(v1);
    }

    // decompiled from Move bytecode v6
}

