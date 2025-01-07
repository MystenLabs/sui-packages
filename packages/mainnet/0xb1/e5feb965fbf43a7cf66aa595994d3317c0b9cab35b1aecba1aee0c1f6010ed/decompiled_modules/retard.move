module 0xb1e5feb965fbf43a7cf66aa595994d3317c0b9cab35b1aecba1aee0c1f6010ed::retard {
    struct RETARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARD>(arg0, 6, b"RETARD", b"SCAMTARD", b"Wow, amazing project, I am experienced shiller and I'd like to offer you a promotion opportunity in my channel. This will help you gain organic volume and followers. We are going to shill the project on telegram, twitter, YouTube, TokTok, reddit, discord, and facebook etc. With over 60_70 guys I will send you proof of work before payment deal. I can get your project listen and trending on all site.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baby_crash_profile_71_098c1faa69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

