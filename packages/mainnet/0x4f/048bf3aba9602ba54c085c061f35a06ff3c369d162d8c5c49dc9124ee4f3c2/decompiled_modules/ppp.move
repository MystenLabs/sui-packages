module 0x4f048bf3aba9602ba54c085c061f35a06ff3c369d162d8c5c49dc9124ee4f3c2::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPP>(arg0, 6, b"PPP", b"POPLE PEPE", b"Pople pepe will shock the meme community on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6004_0200abf2a3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

