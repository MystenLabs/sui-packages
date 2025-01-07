module 0xc58573b95fe139f27dc636928d8e2f2ed2b6917299f98d8afdc4465088e80024::gui {
    struct GUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUI>(arg0, 6, b"GUI", b"Gui Inu (Wormhole)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/aptos/0xe4ccb6d39136469f376242c31b34d10515c8eaaa38092f804db8e08a8f53c5b2::assets_v1::echocoin002.png?size=lg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUI>(&mut v2, 10000001000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

