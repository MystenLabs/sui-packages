module 0xca9104925df8d76c689e6386446e03880d8f657b2777556243ae19d74da2573::lse {
    struct LSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSE>(arg0, 6, b"LSE", b"Lost Sea horse emoji", b"in the sprawling digital ocean of icons and symbols, there once existed an emojismall, seemingly insignificant, yet imbued with mystery. This was the Seahorse Emoji, a symbol that many swear they once saw, used, and even sent in messages to friends. Yet t", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Wefhs_Ra_JL_Yiqgio_Ep_Ni4_Uvcdy_Wngqi2623fm_F_Ka_CAE_9_e22322e4e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

