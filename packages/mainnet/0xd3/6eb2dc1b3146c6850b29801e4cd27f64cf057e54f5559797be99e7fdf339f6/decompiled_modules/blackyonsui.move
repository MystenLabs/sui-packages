module 0xd36eb2dc1b3146c6850b29801e4cd27f64cf057e54f5559797be99e7fdf339f6::blackyonsui {
    struct BLACKYONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKYONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKYONSUI>(arg0, 6, b"Blackyonsui", b"Blacky", b"Blacky is a vibrant and charismatic dog. With his shiny black coat and intelligent eyes, hes the center of attention in every park. Blacky loves to run and play frisbee but also has a sweet side, often cuddling in his owner's lap. His bravery and loyalty make him a true companion, ready for adventures and bringing warmth to the home. Lets delve deeper into the exciting tales of Blacky!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065337_f391cb941f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKYONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKYONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

