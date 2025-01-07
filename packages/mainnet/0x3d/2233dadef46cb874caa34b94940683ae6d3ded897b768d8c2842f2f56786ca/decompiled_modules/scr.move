module 0x3d2233dadef46cb874caa34b94940683ae6d3ded897b768d8c2842f2f56786ca::scr {
    struct SCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCR>(arg0, 6, b"SCR", b"SUICARIO", b"You should move to a big chain where the rule of law still exists", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicario_8c01e1b2ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

