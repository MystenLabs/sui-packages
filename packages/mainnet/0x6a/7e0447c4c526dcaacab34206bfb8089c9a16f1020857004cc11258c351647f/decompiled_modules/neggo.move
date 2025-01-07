module 0x6a7e0447c4c526dcaacab34206bfb8089c9a16f1020857004cc11258c351647f::neggo {
    struct NEGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGGO>(arg0, 9, b"NEGGO", b"Neggo", b"neggo the fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4x7xoqc6ogyBpQ9jKAWRsNJnUkBzAmXsE7nTa3a4pump.png?size=xl&key=1c0348")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEGGO>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

