module 0xd9571b775543e86cf669422b9bf1110cf0d6ea6015e353053d90f468f26d1e40::T47 {
    struct T47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T47>(arg0, 9, b"T47", b"TRUMP 47", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/E5v6zvxCAnAD7n9jpoCMSW1qXgqkg6RNPuumJ7zN4NV1.png?size=xl&key=aca87b")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T47>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T47>>(0x2::coin::mint<T47>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T47>>(v2);
    }

    // decompiled from Move bytecode v6
}

