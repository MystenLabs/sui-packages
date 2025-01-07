module 0x99ad59a1126cac8104c6c39e7502cbabe458c1b3644b1cb5b365c5def0ea3c34::allin {
    struct ALLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLIN>(arg0, 6, b"ALLIN", b"All-in Sui", b"Welcome to the $ALLIN Telegram Community! You've just joined a movement that goes beyond mere holdingit's about standing firm in our belief in Sui. While others may waver, $ALLIN is for the degens who are truly committed, who see the bigger picture, and who are ready to go all in on SUI, no matter what. Here, you'll find like-minded believers who understand the value of staying the course. This is a space where we support each other, share insights, and strengthen our resolve. Together, we're not just holding SUI  we're holding the line. Welcome to the $ALLIN family. Lets make a statement, together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_5fafdd236a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALLIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

