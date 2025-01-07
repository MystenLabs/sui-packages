module 0x1802787649cab1612a6a04a8e9db1589b9b7653928c528911fcc610d746ebdd5::kama {
    struct KAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMA>(arg0, 9, b"KAMA", b"Kamala Horris", b"Kamala Dovo Horris iz an American politishan n attorney who iz da 49th n current vice president of da United States under President Jeo Boden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HnKkzR1YtFbUUxM6g3iVRS2RY68KHhGV7bNdfF1GCsJB.png?size=lg&key=628057")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAMA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

