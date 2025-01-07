module 0x34537f850fa6338f3c84fc6c74c43f098d10afdc696d6ea60d55f1dcc734547f::frogo {
    struct FROGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGO>(arg0, 6, b"Frogo", b"Dr.Frogo", b" Dr. Frogo | The meme coin with a prescription for success!  Fun, frog-themed rewards & community-driven growth. Join the Frog Fam & hop to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000080614_4dedb7c466.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

