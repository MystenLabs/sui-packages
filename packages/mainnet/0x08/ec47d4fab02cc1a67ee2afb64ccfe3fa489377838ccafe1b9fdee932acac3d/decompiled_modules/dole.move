module 0x8ec47d4fab02cc1a67ee2afb64ccfe3fa489377838ccafe1b9fdee932acac3d::dole {
    struct DOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLE>(arg0, 9, b"DOLE", b"Doleduidui", x"565549204cc38a4e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d4848290d67eaffba33254189353c1b6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

