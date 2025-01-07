module 0x7d1c9433668cca858fd65035c5141b0db36fce203f4e1952f00406bbdb4fdcbb::man {
    struct MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAN>(arg0, 6, b"MAN", b"Suiderman", b"Suiderman is a Suihero meme on Sui blockchain.Community driven meant to exist for fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4444_Photoroom_3_1f94f1118e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

