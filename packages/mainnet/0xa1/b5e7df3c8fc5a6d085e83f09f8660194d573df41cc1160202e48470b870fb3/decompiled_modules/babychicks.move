module 0xa1b5e7df3c8fc5a6d085e83f09f8660194d573df41cc1160202e48470b870fb3::babychicks {
    struct BABYCHICKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCHICKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCHICKS>(arg0, 6, b"BABYCHICKS", b"Baby Chicks", b"The power of cuteness can never be underestimated! Baby Chicks is not only an investment tool, but also a project that will bring a smile to your face. Its logo and mascot, a sweet blue-eyed chick, aims to make you happy every time you look at it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734092025084.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYCHICKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCHICKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

