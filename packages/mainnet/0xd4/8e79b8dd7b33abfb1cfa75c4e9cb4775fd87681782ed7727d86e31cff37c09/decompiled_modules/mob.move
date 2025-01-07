module 0xd48e79b8dd7b33abfb1cfa75c4e9cb4775fd87681782ed7727d86e31cff37c09::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 6, b"MOB", b"MOB ON SUI", b"Mob the greates whale on SUI ocean, with good narrative.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3908_a333d6ab15.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

