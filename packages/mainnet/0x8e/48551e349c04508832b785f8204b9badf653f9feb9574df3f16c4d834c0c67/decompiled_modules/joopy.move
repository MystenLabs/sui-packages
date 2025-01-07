module 0x8e48551e349c04508832b785f8204b9badf653f9feb9574df3f16c4d834c0c67::joopy {
    struct JOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOPY>(arg0, 9, b"JOOPY", b"JOOP", b"Joopy meme: A wide-eyed character reacting to everyday frustrations with funny captions like \"Joopy when life gets confusing.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1359233508036800518/97jqsevm.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOOPY>(&mut v2, 140000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOPY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

