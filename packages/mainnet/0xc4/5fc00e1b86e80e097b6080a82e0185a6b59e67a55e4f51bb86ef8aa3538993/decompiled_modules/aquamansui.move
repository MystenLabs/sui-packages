module 0xc45fc00e1b86e80e097b6080a82e0185a6b59e67a55e4f51bb86ef8aa3538993::aquamansui {
    struct AQUAMANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAMANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAMANSUI>(arg0, 6, b"AQUAMANSUI", b"SUPERHERO ON SUI", b"Superhero mascot sui $AQUAMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3591_ef67c69fd3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAMANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

