module 0xb646e9630bd2793b6d636fb1538329d1c69a920fa30bd37e39aecb8bbcf208c::bulbear {
    struct BULBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBEAR>(arg0, 6, b"BULBEAR", b"BULL vs BEAR", b"A bloody fight between a Bull and a Bear....we all wish the bull to win....who do you think will end up defeating the other?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bullbear_5678e6ea89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

