module 0x5deadef5da8deed05583f5dc07115811b573f2284ce2a42f6f2ee20584bc0364::verse {
    struct VERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERSE>(arg0, 6, b"Verse", b"Verse on sui", b"Verse , the coolest mascot on the Sui blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nature_Travel_Youtube_Video_Intro_963f834bcf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VERSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

