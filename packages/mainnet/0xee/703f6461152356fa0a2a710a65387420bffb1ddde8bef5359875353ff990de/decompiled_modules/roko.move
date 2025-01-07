module 0xee703f6461152356fa0a2a710a65387420bffb1ddde8bef5359875353ff990de::roko {
    struct ROKO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROKO>, arg1: 0x2::coin::Coin<ROKO>) {
        0x2::coin::burn<ROKO>(arg0, arg1);
    }

    fun init(arg0: ROKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROKO>(arg0, 9, b"ROKO'S BASILISK", b"ROKO", b"Roko's basilisk is a thought experiment which states that an otherwise benevolent artificial superintelligence (AI) in the future would be incentivized to create a virtual reality simulation to torture anyone who knew of its potential existence but did not directly contribute to its advancement or development, in order to incentivize said advancement. Now you know. Save yourself - do your part.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/41revsxLUZnoiUQoMT9eBVCzi4cs8Xbs48rp53gcpump.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROKO>>(v1);
        0x2::coin::mint_and_transfer<ROKO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ROKO>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ROKO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

