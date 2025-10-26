module 0x8312791eb7c4dc1f0d206686d9c60f0f56ad5fa3e6bd45778c2aeab01fece7c7::ant {
    struct ANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANT>(arg0, 6, b"ANT", b"antoshka", b"mem token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Bez_nazvaniya_2_8d9145c2d9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

