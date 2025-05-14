module 0x1476ba1cc4d6f20f2c7b47d28eda84b3edfa4729f8ec645515d486024929ee62::pizizi {
    struct PIZIZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZIZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZIZI>(arg0, 6, b"PIZIZI", b"Pizizi", b"I'm just a Pizizi bear who wants to go to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069922_8ee416e1e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZIZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZIZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

