module 0xd9ac43fdfce5bf988256e927665736ac1fd0b3a01fff303e20972fcb3723daaa::kido {
    struct KIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDO>(arg0, 9, b"KIDO", b"KAIDAWG", b"KAIDAWG is a black poodle with name Kevin. He likes to chase motorcycle and bark at strangers to ask for belly rubs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25d681d5-267d-4ca2-91bf-8fefaeb7ecf0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

