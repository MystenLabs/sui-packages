module 0x56f278558cde0595544cb980ce3ee67ecd88808123907d1ce3f4c2aa5ef66288::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 9, b"HOP", b"Hop", b"Suck My ass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/ghdf0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HOP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

