module 0x806ec7f36415a0d8a0b5811fdd8f270b9ab3fa4cf8d337d16528a671289afb2c::TRUMPGOD {
    struct TRUMPGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPGOD>(arg0, 9, b"TrumpGod", b"Trump is God", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/8kJNrDyBsNoHqdt5ZkaMw4cXrBd1ik6SA4i59qM82sQW.png?size=lg&key=de28f4")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPGOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPGOD>>(0x2::coin::mint<TRUMPGOD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMPGOD>>(v2);
    }

    // decompiled from Move bytecode v6
}

