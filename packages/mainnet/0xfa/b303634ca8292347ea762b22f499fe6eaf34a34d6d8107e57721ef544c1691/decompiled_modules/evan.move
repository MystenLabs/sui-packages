module 0xfab303634ca8292347ea762b22f499fe6eaf34a34d6d8107e57721ef544c1691::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 6, b"EVAN", b"Evan on SUI", b"$EVAN, inspiretd by Evan Cheng - the founder of SUI Blockcheen - the memecoin for the autisstic and retardzz nerdz that make SUI great. evanonsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qqe_Lg_Wo_B_400x400_6eb791fb4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

