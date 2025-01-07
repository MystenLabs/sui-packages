module 0x4e7af2bf5187406c722f60cefb777905c3781c64ddd2db9f9ce2cc79393c2382::sadant {
    struct SADANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADANT>(arg0, 6, b"SADANT", b"Sad Ant", b"Meet Sad Ant, the most hardworking ant on the blockchain, ready to turn her frown upside down! With $SADANT, every purchase helps her rebuild her anthill of joyand maybe yours too. Let's create some buzz and make Sad Ant happy again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050348_1c7817b173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

