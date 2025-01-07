module 0x8e65ca3f4a97cee42059838f0805f2ee17962c7075fb5c9eafd4539ff8d5bf01::HESTER {
    struct HESTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HESTER>(arg0, 9, b"HESTER", b"Crypto Mom", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x004268cfede2458d9d356bd8cfb2b5d277bf1295.png?size=xl&key=2359f2")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HESTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HESTER>>(0x2::coin::mint<HESTER>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HESTER>>(v2);
    }

    // decompiled from Move bytecode v6
}

