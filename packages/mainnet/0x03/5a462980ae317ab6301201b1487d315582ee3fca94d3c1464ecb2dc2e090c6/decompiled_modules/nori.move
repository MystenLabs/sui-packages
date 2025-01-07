module 0x35a462980ae317ab6301201b1487d315582ee3fca94d3c1464ecb2dc2e090c6::nori {
    struct NORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORI>(arg0, 6, b"NORI", b"NoriTheDog", b"Hey, look at me, I'm Nori. Don't make me angry!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2270_removebg_preview_01_347ccf096d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

