module 0xf435d726497d97f0acbbf9a36ffdf2f15cad3f0535e7e10d076edd9a122346aa::siuuuu {
    struct SIUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUUU>(arg0, 6, b"SIUUUU", b"SIUUUU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tickerperry.xyz/siuuuu.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUUUU>>(v1);
        0x2::coin::mint_and_transfer<SIUUUU>(&mut v2, 5000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUUU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

