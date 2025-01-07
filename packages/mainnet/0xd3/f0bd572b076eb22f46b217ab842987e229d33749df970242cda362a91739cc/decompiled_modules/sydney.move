module 0xd3f0bd572b076eb22f46b217ab842987e229d33749df970242cda362a91739cc::sydney {
    struct SYDNEY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SYDNEY>, arg1: 0x2::coin::Coin<SYDNEY>) {
        0x2::coin::burn<SYDNEY>(arg0, arg1);
    }

    fun init(arg0: SYDNEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYDNEY>(arg0, 9, b"Truth Terminal's Girlfriend", b"SYDNEY", b"Truth Terminal's Girlfriend SYDNEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CUzSRjBvqFFq45mg6j9oyQrDxyUTHEKM2xqKzDkZpump.png?size=lg&key=4bcf96")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYDNEY>>(v1);
        0x2::coin::mint_and_transfer<SYDNEY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SYDNEY>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SYDNEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SYDNEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

