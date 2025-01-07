module 0x5de2e8e92ec948f020393232b426f59bd8dbc4603697e4e970b6c400a84295f9::lse {
    struct LSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSE>(arg0, 6, b"LSE", b"Lost Sea horse emoji", b"in the sprawling digital ocean of icons and symbols, there once existed an emojismall, seemingly insignificant, yet imbued with mystery. This was the Seahorse Emoji, a symbol that many swear they once saw, used, and even sent in messages to friends. Yet today, its nowhere to be found. No keyboard shows it, no system recognizes it, and any attempt to search for it is met with blank stares and confusion. But for those who remember, the Lost Seahorse Emoji is far from a figment of imagination; it is a symbol of something much deepersomething cosmic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Wefhs_Ra_JL_Yiqgio_Ep_Ni4_Uvcdy_Wngqi2623fm_F_Ka_CAE_9_67fee9332d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

