module 0x81cb2569a1b9474f854b1b45ee07d86e0f5e18309167cf97493fe76300193bb8::trumpin {
    struct TRUMPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPIN>(arg0, 6, b"TRUMPIN", b"Trumpin Make America Great Again", b"wont stop fighting until we go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zx_Cc_Vs_Xs_A0az_Aj_ac1cb031a2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

