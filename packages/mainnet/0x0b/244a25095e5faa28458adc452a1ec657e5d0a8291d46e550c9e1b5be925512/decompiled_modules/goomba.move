module 0xb244a25095e5faa28458adc452a1ec657e5d0a8291d46e550c9e1b5be925512::goomba {
    struct GOOMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOMBA>(arg0, 6, b"GOOMBA", b"goomba", b"Goomba is just a little guy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1222222_6a6dbea92d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

