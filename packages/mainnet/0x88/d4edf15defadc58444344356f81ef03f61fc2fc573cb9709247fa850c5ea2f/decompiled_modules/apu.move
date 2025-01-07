module 0x88d4edf15defadc58444344356f81ef03f61fc2fc573cb9709247fa850c5ea2f::apu {
    struct APU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APU>(arg0, 9, b"APU", b"Apu Apustaja", b"Join us on this amazing ride to the only place where a character like Apu belongs to: the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x3159fb5589acd6bf9f82eb0efe8382ed55aed8fd.png?size=xl&key=fc7364")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APU>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APU>>(v1);
    }

    // decompiled from Move bytecode v6
}

