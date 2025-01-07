module 0x4056aaf73ea9e9a946c92ad698c47f8a36ebcd7c71a9164ad13fec2f8a0e1ba1::surfsui {
    struct SURFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURFSUI>(arg0, 6, b"SURFSUI", b"SurfSui", b"Surf on water. Surf on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Surfer_eeabe9784f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

