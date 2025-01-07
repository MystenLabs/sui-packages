module 0x17b6be650b5b456b879c5277fd1237826de4e5ef8737759bb98084bd754ef060::swish {
    struct SWISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWISH>(arg0, 6, b"SWISH", b"CAT IN A FISH WORLD", b"$MEW NARRATIVE IN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240930_180653_860_46c8035fb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

