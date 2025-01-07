module 0xfca7888b8d807d883f908a3db63159f17ef02f6c99b36b55830b2900a71f863::etw {
    struct ETW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETW>(arg0, 6, b"ETW", b"Epic Trump Win", b"Epic Trump Win (ETW) is not just a meme coin... it's a statement, a badge, and maybe, just maybe, a prophecy. Whether you're here for the lulz, the lore, or the financial thrill, ETW embodies the essence of going against the grain with a smile (or smirk).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma7_U5_WQ_9_Pf1km_R8_Y_Vjdv_Hw_Sp26m3gfew8n_Fi7mx_FW_7s_VX_78a1f9ae8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETW>>(v1);
    }

    // decompiled from Move bytecode v6
}

