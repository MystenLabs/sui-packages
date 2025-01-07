module 0x48f1c5e51c5c2de960db1bdc7190ef2c8b00bbc73e0b99dc66d40d4154ddea6f::akane {
    struct AKANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKANE>(arg0, 6, b"AKANE", b"AKANE AI", b"Talk with me, babe.I'm your AI girlfriend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_fae3ad4764.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

