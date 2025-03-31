module 0x9f8f74cfb151ce1808715d9869277d0deb7f9aca247566d44d298a06f1531f41::joks {
    struct JOKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKS>(arg0, 9, b"JOKS", b"Joker Soul", b"Free Soul is Power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fb604944b031e897df675fa87fbf2763blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

