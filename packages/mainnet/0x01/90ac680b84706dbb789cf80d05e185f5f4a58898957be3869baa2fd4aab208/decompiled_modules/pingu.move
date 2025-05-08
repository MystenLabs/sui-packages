module 0x190ac680b84706dbb789cf80d05e185f5f4a58898957be3869baa2fd4aab208::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 9, b"PINGU", b"Pingu", b"PinguPinguPingu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HMRh9ksQTe2SXWLxaNTd2u8PTX9mcodUgzedDMaLbonk.png?size=xl&key=84367a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PINGU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

