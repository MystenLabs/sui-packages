module 0x58d58ab44445cca07969ca112817582da6f806abad2cc8fbf75a367943c5efcb::pororo {
    struct PORORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORORO>(arg0, 6, b"PORORO", b"Pororo Sui", b"Loopy's friend named Pororo, the little penguin, was always up for fun. One day, they decided to have a race down a snowy hill. Pororo slipped and tumbled, landing right in a pile of snow! Laughing, Loopy joined him, and they rolled around, creating snow angels and giggling together. Their playful spirit made every day an adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pororos_fc11ec08ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

