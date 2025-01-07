module 0x39e094724fcda4a0f0508b14ef60bb0ab51df172ab232865dc98298d390a87e0::suikater {
    struct SUIKATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKATER>(arg0, 6, b"SUIKATER", b"SUIKATER BIRD", b"SUIKATER BIRD DOING KICK-FLIPS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bird_25895e3c25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

