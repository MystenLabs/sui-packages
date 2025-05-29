module 0x6e7247ccb16181b3ad1c760b269416db2b03cf0c10562dddcd41f775614c84a6::sliki {
    struct SLIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIKI>(arg0, 9, b"SLIKI", b"Sliki", b"Sophisticated Degeneracy only on $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x1f0072611d39f5f422bce48de7cb5759381bff8f9e9751d7372a90a39475ac44::slik::slik.png?size=lg&key=2a5716")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLIKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SLIKI>>(0x2::coin::mint<SLIKI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SLIKI>>(v2);
    }

    // decompiled from Move bytecode v6
}

