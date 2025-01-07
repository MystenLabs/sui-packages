module 0x3f4cd998dbc63f7c6ac7dba26d4195e7cd2dd6e2740223c700382e8fd24ded16::scum {
    struct SCUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUM>(arg0, 6, b"SCUM", b"Scum on SUI", b"Scum is the first-ever artwork by Matt Furie on his website, http://mattfurie.com (2004). Matt Furie told us to send this unique character, so we are truly sending it by bringing it to life. $SCUM is now live and out for the hunt!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_G_Nh_RGJ_400x400_3e4d7669de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

