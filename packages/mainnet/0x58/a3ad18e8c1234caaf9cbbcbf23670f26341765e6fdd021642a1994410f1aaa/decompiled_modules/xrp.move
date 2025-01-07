module 0x58a3ad18e8c1234caaf9cbbcbf23670f26341765e6fdd021642a1994410f1aaa::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 9, b"XRP", b"HarryPotterObamaPacMan8Inu", b"HarryPotterObamaPacMan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x07e0edf8ce600fb51d44f51e3348d77d67f298ae.png?size=lg&key=ef4e37")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XRP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

