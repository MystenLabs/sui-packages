module 0xb45525e9b1f039b2160f0309d20a1a8580a81c2442bf44d1e791070217e3d3b4::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOL>(arg0, 9, b"AXOL", b"AXOL", b"Smiling Ear to Ear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xae00e078a46616bf6e1e6fb673d18dcd2aa31319a07c9bc92f6063363f597b4e::axol::axol.png?size=lg&key=137c22")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AXOL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

