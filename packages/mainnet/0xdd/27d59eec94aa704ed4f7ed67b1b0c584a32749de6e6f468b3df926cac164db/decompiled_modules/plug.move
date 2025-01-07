module 0xdd27d59eec94aa704ed4f7ed67b1b0c584a32749de6e6f468b3df926cac164db::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"PLUG", b"plug", b"Plug is determined to soak everyone who believes in Suis future. Plug can feel the power of the entire crypto community. Just enjoy the water and dont assign too much meaning to it. The person who opens Plugs valve for you is the silent Rebel, and Plug is very generous when in their hands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cd6d4070_84c2_4454_8b76_ab43959aa393_1ff824a4a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

