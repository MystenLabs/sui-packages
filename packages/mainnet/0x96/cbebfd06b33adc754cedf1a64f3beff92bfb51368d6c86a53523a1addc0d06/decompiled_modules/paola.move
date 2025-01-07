module 0x96cbebfd06b33adc754cedf1a64f3beff92bfb51368d6c86a53523a1addc0d06::paola {
    struct PAOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAOLA>(arg0, 6, b"Paola", b"Paolacoin", b"Paola meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009736_045514382e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

