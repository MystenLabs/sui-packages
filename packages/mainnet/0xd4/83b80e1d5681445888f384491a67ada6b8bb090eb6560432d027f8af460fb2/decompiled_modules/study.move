module 0xd483b80e1d5681445888f384491a67ada6b8bb090eb6560432d027f8af460fb2::study {
    struct STUDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUDY>(arg0, 6, b"STUDY", b"Study On Sui", b"Lessons on how to moon have begun on Tron. Do what's best for your homies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_b90090ae57.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

