module 0x9b4ad4aeddc05434ccb1e68711abd39021d627fb14e1ac2cf66078c77049ecab::mndog {
    struct MNDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNDOG>(arg0, 6, b"MNDOG", b"MOONDOG", b"\"MOONDOG\" is a memecoin that embodies the excitement and ambition of reaching for the stars, featuring a dynamic and adventurous canine mascot. The visual representation of MOONDOG is a futuristic rocket with the head of a determined dog at the front, symbolizing the coins unstoppable drive toward success. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/rocket_fed094098e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

