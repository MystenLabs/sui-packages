module 0x4e7a6f5b1176f1a216060a13e141d88e640f081dcf07f99e30d66bba034cca37::tiedan {
    struct TIEDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIEDAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIEDAN>(arg0, 6, b"TIEDAN", b"TieDansui", b"Justin Sun's Only Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PXP_Htusg_400x400_4d1f4e5bbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIEDAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIEDAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

