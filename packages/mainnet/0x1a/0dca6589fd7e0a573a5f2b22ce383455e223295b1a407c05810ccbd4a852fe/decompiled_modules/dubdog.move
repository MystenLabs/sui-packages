module 0x1a0dca6589fd7e0a573a5f2b22ce383455e223295b1a407c05810ccbd4a852fe::dubdog {
    struct DUBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBDOG>(arg0, 6, b"DUBDOG", b"Dubdog Sui", b"$DUBDOG is a Sui based coin launching on day 1 of Dub Social. A launchpad that rewards token holders for working for their bags!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul53_e80524a0d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUBDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

