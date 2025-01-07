module 0x3ac199c1e8de70414b82aa49246628b1da21cf6dbdfb3d9bc08f134ebf595085::ppheart {
    struct PPHEART has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPHEART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPHEART>(arg0, 6, b"PPHEART", b"Pepe Heart", b"The best person in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4141_361e66b581.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPHEART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPHEART>>(v1);
    }

    // decompiled from Move bytecode v6
}

