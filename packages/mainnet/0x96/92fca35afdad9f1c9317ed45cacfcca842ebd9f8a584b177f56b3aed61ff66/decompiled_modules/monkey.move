module 0x9692fca35afdad9f1c9317ed45cacfcca842ebd9f8a584b177f56b3aed61ff66::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"Monkey", b"Sui Monkey", b"The original monkey meme coin on the Sui blockchain! Get in on the ground floor with Sui Monkey and be part of the OG Monkey coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QQ_20240912_204325_c00e199cfe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

