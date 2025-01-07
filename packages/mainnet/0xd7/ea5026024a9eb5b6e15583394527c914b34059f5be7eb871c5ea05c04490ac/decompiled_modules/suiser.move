module 0xd7ea5026024a9eb5b6e15583394527c914b34059f5be7eb871c5ea05c04490ac::suiser {
    struct SUISER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISER>(arg0, 6, b"SUISER", b"Suiser", b"Only one sir thought of a memecoin that was supported by the community until it was launched on a tier 1 exchange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048366_b22dbcca07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISER>>(v1);
    }

    // decompiled from Move bytecode v6
}

