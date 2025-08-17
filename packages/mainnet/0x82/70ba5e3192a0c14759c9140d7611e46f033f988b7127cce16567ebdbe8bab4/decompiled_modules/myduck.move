module 0x8270ba5e3192a0c14759c9140d7611e46f033f988b7127cce16567ebdbe8bab4::myduck {
    struct MYDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYDUCK>(arg0, 6, b"MYDUCK", b"MyDuck", b"MyDuck it just a meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755432935507.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

