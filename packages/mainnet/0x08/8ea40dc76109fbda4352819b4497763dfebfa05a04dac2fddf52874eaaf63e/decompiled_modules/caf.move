module 0x88ea40dc76109fbda4352819b4497763dfebfa05a04dac2fddf52874eaaf63e::caf {
    struct CAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAF>(arg0, 6, b"CAF", b"CAT F SUI", b"just cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_28_19_06_23_removebg_preview_e3399d5781.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

