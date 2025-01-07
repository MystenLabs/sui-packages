module 0x7978e82e46d6444ae0047d6c0e98500edee2f1883fa07af8c4f0c9f88609c725::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 6, b"SQUIRT", b"SUI SQUIRT", b"SUI SQUIRT is the ultimate meme token on the SUI blockchain, featuring a wild water droplet mascot. $SQUIRT combines chaos, humor, and community energy to make waves in the crypto world. Join the splash and be part of the liquidity-fueled fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734984940010.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

