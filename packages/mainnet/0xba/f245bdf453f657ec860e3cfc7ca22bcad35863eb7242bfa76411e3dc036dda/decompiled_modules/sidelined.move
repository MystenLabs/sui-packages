module 0xbaf245bdf453f657ec860e3cfc7ca22bcad35863eb7242bfa76411e3dc036dda::sidelined {
    struct SIDELINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDELINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDELINED>(arg0, 9, b"SIDELINED", b"sidelined", b"are you sidelined anon?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXXg5hJ1BbfpGjm4ro5hUNePy1vUTAKZ3paqMmzd6W65f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIDELINED>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIDELINED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDELINED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

