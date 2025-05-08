module 0x5f156e9d7054cb5d86861145b9c2d581f2bc2166e185573092a7a6bca6337f6c::foxy {
    struct FOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXY>(arg0, 9, b"FOXY", b"Foxy", b"Foxy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xf28147869eb343b0786093ecb6afa6999f4a0d94.png?size=xl&key=c59305")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOXY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXY>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

