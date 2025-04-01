module 0xb3fe253e2472f3b52731b1b83b687a77d3e26deafeb899b0868ac49bad1688e4::mcltoken {
    struct MCLTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCLTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCLTOKEN>(arg0, 6, b"MCLToken", b"Michelin Man", b"Michelin Man, also known as Bibendum, is the official mascot of the Michelin tire company. He is a distinctive, chubby figure made of stacked white tires, symbolizing durability, comfort, and safety in Michelins products", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2532545f_b552_4a3b_8fec_9004e81bf317_f3cf2994ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCLTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCLTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

