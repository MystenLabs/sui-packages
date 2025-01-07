module 0x347a95424140fcd8f69317c81bacc05cd665bfbc27839c2e845f6a579a52b080::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BS>(arg0, 6, b"BS", b"Bullshit", b"Bullshit makes millionaires ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009466_1727939544.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BS>>(v1);
    }

    // decompiled from Move bytecode v6
}

