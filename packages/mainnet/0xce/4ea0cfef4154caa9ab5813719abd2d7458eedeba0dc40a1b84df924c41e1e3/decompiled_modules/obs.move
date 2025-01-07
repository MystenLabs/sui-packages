module 0xce4ea0cfef4154caa9ab5813719abd2d7458eedeba0dc40a1b84df924c41e1e3::obs {
    struct OBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBS>(arg0, 6, b"OBS", b"Onine Boss on SUI", b"Giveaway 100$ x account follow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ergege_80c9a3582e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

