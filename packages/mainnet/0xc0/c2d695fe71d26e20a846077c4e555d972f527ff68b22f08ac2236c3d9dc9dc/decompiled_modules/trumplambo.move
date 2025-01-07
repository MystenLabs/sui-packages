module 0xc0c2d695fe71d26e20a846077c4e555d972f527ff68b22f08ac2236c3d9dc9dc::trumplambo {
    struct TRUMPLAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLAMBO>(arg0, 6, b"TRUMPLAMBO", b"Trump Lambo", b"Trump Lambo is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731425558103.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

