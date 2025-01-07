module 0x1ed50e928b4c1b4e8d0c4ce180f692ebd348f24ec561bb8bf4ce77e9e051c5a4::sperm {
    struct SPERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPERM>(arg0, 9, b"SPERM", b"Sperm", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/3CjKuqo9gsstztuUSDybSfnycxoYZUru4LxpCiHxpump.png?size=xl&key=c61d98")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPERM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPERM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPERM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

