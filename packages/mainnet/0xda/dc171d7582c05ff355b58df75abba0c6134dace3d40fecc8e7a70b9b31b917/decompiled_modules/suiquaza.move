module 0xdadc171d7582c05ff355b58df75abba0c6134dace3d40fecc8e7a70b9b31b917::suiquaza {
    struct SUIQUAZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQUAZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQUAZA>(arg0, 6, b"SUIQUAZA", b"SUIQUAZA Ruler of the Sky", b"$SUIQUAZA The legendary Pokemon who rules the sky. Coming to the sea of $SUI to dominate and rule all the Pokemons whether on land or ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigz2hdmdrorpiwuhyh4dlkzfv4ichhvddgyznxxzvkwfyguc727zy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQUAZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIQUAZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

