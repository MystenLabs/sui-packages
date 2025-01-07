module 0x42d9e411317a86c27c4991ce3d20903d88f06ae6ef8fef691b4fef5fd1bd9521::poptardio {
    struct POPTARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTARDIO>(arg0, 9, b"POPTARDIO", b"Poptardio", b"pop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EHkBE68qJx7mepNSDe6nccz7WpaNdzy9x6Pqc6C1kTaJ.png?size=xl&key=64bb8e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPTARDIO>(&mut v2, 7000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTARDIO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

