module 0x7b0d45635e172815887da1e67e93762757237cfc12469ab0e03e5b452805a25c::nyanmas {
    struct NYANMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYANMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYANMAS>(arg0, 9, b"NYANMAS", b"Christmas's Nyan Cat", b"Welcome to $NYANMAS, spreading festive cheer with the holiday magic of Nyan Cat! Inspired by the iconic pop-tart feline and infused with Christmas spirit, our token brings joy, nostalgia, and a sprinkle of starlit wonder to the season. Join us in celebrating the whimsy and magic of $NYANMAS this holiday!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4rbAQqN2z5VCNe6AgvxnXC8muXoghEXEyADxdmXipump.png?size=lg&key=c70655")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NYANMAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYANMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYANMAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

