module 0x7e264123cc586768c0931d7609f13b99695a8980b17c8d68cfbd30939411a84d::SKG {
    struct SKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKG>(arg0, 9, b"SKG888", b"Safu & Kek Gigafundz 888", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Dc29xEisYZXfCV3WHgyhjnwPYS53fZ1n2YPGFEC1pump.png?size=xl&key=334109")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SKG>>(0x2::coin::mint<SKG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SKG>>(v2);
    }

    // decompiled from Move bytecode v6
}

