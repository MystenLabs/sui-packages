module 0xe6258f9b58e879d68e1d1fb65a8e4fc39b1c2673ca702903f7b113d4d91b2586::claws {
    struct CLAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWS>(arg0, 6, b"CLAWS", b"Angry Cat Club", b"a bunch of angry cats sick of getting rugged and jeeted on Sui Network. Time for us to fight back with $CLAWS. Although initially a meme play, we plan to release an NFT collection which gate tools to help angry cats spot the red flags early on  Check our site for burn milestones and come and join us on Telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/angry_cat_club_logo_f2a1efadf5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

