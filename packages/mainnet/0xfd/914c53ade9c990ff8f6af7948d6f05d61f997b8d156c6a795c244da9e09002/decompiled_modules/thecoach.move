module 0xfd914c53ade9c990ff8f6af7948d6f05d61f997b8d156c6a795c244da9e09002::thecoach {
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

