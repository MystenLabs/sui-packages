module 0x897b95d83223afec71896a967c5ffb3c58d5f60dee4387b81f51e9527085f4e::jaws {
    struct JAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWS>(arg0, 6, b"JAWS", b"Jaws - The Famous Shark on SUI", b"Brace yourself, the king of the deep is BACK! Remember the shark that made you jump? Well, $JAWS has surfaced on SUI, and its ready to feast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1671728905180_pic_4300580c2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

