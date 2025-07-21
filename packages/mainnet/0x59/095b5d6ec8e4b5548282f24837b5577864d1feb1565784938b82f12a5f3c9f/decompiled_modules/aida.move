module 0x59095b5d6ec8e4b5548282f24837b5577864d1feb1565784938b82f12a5f3c9f::aida {
    struct AIDA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIDA>, arg1: 0x2::coin::Coin<AIDA>) {
        0x2::coin::burn<AIDA>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<AIDA>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDA>>(arg0, @0x0);
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDA>(arg0, 6, b"AIDA", b"AI Decentralised Agents", b"AI Decentralised Agents on Sui. Build, train & monetize AI without code. Secure, no-code AI on the blockchain http://aidasui.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Blhr28z.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIDA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIDA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

