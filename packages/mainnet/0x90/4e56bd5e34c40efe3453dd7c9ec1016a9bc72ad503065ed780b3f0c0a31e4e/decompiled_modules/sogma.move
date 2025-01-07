module 0x904e56bd5e34c40efe3453dd7c9ec1016a9bc72ad503065ed780b3f0c0a31e4e::sogma {
    struct SOGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGMA>(arg0, 9, b"SOGMA", b"Sogma", b"I am $SOGMA. Hard core coin noone can resist!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8wThJ3KAyGWKbZMUg7Pna9SstayjXCvfiwhf75WLpump.png?size=xl&key=a789b1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOGMA>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

