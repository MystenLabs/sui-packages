module 0x29bbc89b17618e959bce740c721def702e25ffbbc6b76fe7ddb7e2b7b8df9b5f::neirasui {
    struct NEIRASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRASUI>(arg0, 6, b"NEIRASUI", b"NEIRA ON SUI", b"$NEIRASUI, Neiro's woman, is arriving to ride the wave of the crypto market on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_001839_006_e32e4a7556.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

