module 0x54755bb688835d41572014ef0a1a5b2ead323ef143ef6adeb932a4f7c60dceba::suigay {
    struct SUIGAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAY>(arg0, 6, b"SUIGAY", b"TheSuiGay", x"576520617265207265616c20616e642072656d656d6265722074686520747275746820616c7761797320636f6d6573206f75742e0a57656c636f6d6520746f20746865206e657720476f64206f6620537569204d656d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sgay_be4eef30e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

