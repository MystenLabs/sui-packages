module 0x3bbe1afefacaefef48b1eae091971e11d1ed494808584103f37aa2fe8d711639::tnc {
    struct TNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TNC>(arg0, 6, b"TNC", b"Trump Nation Coin by SuiAI", b"In the land of digital dollars, the Trump Nation Coin was king - or at least, it thought so. Its design? A warhol version of Trump, mane-like hair and all, with a MAGA-hatted eagle on the flip side. This coin was wild; one tweet from its account, and its value could skyrocket or plummet faster than you could say 'You're fired!' Investors rode its ups and downs like a rollercoaster, laughing or crying at each tweet. 'I'm the best coin, folks, the best,' it would boast. One day, a guy left his wallet full of Trump Coins on a bench, only to find them multiplied upon return. But when he tried to use them, poof! They vanished, leaving behind only Trump's signature chuckle. That's the Trump Nation Coin for you - part currency, part comedy show.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/66_a44c3cfff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TNC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

