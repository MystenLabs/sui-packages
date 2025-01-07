module 0x7b490898183f7e2f6d9074eb93af85133222736ce196e077ddf674d5dd4f0415::croxo {
    struct CROXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROXO>(arg0, 6, b"CROXO", b"Croxo Sui", b"Legend has it that deep in the swamp of memes, a group of mischievous crocodiles got bored watching BLUB rule. They decided it was time to elect a new king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018593_1abc83401d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

