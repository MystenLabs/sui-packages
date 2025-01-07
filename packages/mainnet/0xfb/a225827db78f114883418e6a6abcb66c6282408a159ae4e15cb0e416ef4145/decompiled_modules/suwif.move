module 0xfba225827db78f114883418e6a6abcb66c6282408a159ae4e15cb0e416ef4145::suwif {
    struct SUWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWIF>(arg0, 6, b"SUWIF", b"SUI WIF HAT", b"Sui Wif Hat Token is the coolest, most stylish memecoin on the Sui blockchain, rocking a sleek hat that gives it extra charm and swagger. This token strolls through the crypto world with confidence, tipping its hat at every price swing and trend. Whether the market's up or down, Sui Wif Hat always keeps its cool, proving that when it comes to crypto, a little style goes a long way. #HatPower #StylishCrypto #TipTheHat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_4a95f1df2c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

