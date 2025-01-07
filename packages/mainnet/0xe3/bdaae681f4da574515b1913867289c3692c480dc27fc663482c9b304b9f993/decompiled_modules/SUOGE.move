module 0xe3bdaae681f4da574515b1913867289c3692c480dc27fc663482c9b304b9f993::SUOGE {
    struct SUOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUOGE>(arg0, 9, b"SUOGE", b"Doge of Sui", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HVR8QZpNnhf7zVcmMfW49sozbdKbg39JmdCQbt6Spump.png?size=xl&key=519787")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUOGE>>(0x2::coin::mint<SUOGE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUOGE>>(v2);
    }

    // decompiled from Move bytecode v6
}

