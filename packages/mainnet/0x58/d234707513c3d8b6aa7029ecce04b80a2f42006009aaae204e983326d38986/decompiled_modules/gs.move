module 0x58d234707513c3d8b6aa7029ecce04b80a2f42006009aaae204e983326d38986::gs {
    struct GS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GS>(arg0, 6, b"GS", b"Gunshot", b"don't belive me real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gun_preview_Bgc_Jzvmz_f085e3eba1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GS>>(v1);
    }

    // decompiled from Move bytecode v6
}

