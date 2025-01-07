module 0x5b52cfae942d65443abf9ff17f36a2530962355b3a3fa3ce59677daa96a6297b::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"OTTER", b"$OTTER ON SUi", b"This token is leading the flock with its unique vibe and community power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_5be0ffb982.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

