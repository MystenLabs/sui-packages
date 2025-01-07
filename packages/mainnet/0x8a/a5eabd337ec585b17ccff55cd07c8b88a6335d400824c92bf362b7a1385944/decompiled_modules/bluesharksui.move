module 0x8aa5eabd337ec585b17ccff55cd07c8b88a6335d400824c92bf362b7a1385944::bluesharksui {
    struct BLUESHARKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUESHARKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUESHARKSUI>(arg0, 6, b"BLUESHARKSUI", b"BLUE EYE SHARK SUI", b"INSPIRED BY THE BLUE EYE DOG MEME COIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l8oqwm_caf348eb11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUESHARKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUESHARKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

