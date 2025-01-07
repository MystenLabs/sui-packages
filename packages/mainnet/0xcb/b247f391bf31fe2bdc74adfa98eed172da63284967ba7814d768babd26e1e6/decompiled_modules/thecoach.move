module 0xcbb247f391bf31fe2bdc74adfa98eed172da63284967ba7814d768babd26e1e6::thecoach {
    struct THECOACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: THECOACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THECOACH>(arg0, 6, b"TheCoach", b"The Coach(Wayne Rooney)", b"The Coach(Wayne Rooney) is an English professional football manager and former player who is the head coach of EFL Championship club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ytlw_Ab_W4_AAI_Oz7_762c8f0716.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THECOACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THECOACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

