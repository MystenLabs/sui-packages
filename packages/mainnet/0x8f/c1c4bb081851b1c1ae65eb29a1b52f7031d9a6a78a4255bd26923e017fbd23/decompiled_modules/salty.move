module 0x8fc1c4bb081851b1c1ae65eb29a1b52f7031d9a6a78a4255bd26923e017fbd23::salty {
    struct SALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALTY>(arg0, 9, b"Salty", b"Salty", b"\"the brighter you shine the darker your haters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/ENFcR4n3TTSzwDLxuCst3dUq8HvA1czhDB98cj8Ppump.png?size=xl&key=b2f6a8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SALTY>(&mut v2, 7000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

