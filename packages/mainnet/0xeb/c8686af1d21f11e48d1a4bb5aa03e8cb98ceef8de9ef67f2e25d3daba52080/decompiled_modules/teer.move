module 0xebc8686af1d21f11e48d1a4bb5aa03e8cb98ceef8de9ef67f2e25d3daba52080::teer {
    struct TEER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEER>, arg1: 0x2::coin::Coin<TEER>) {
        0x2::coin::burn<TEER>(arg0, arg1);
    }

    fun init(arg0: TEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEER>(arg0, 4, b"TEER", b"TEER", b"TEER coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HcuSvWb7zJatFyy1PsNBBQTJuFh4fo23X3yfyNv8U5TV.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xaf5e0947b1d00c6f287becc210ab92f471c7cd8bba9f29f107179b535e6d4dd8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEER>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEER>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEER>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEER>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

