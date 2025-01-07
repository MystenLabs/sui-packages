module 0x2525cea91ca975931b1c4951997cfe72103424272163e72c64541cc25bc99d60::nuggets {
    struct NUGGETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUGGETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUGGETS>(arg0, 9, b"NUGGETS", b"Nuggets", b"The Rise of NuggetS: From Trash to Crypto Tycoon.  Once a forgotten nugget, chucked in the trash like yesterday's garbage, this little bastard refused to stay down. With a defiant \"fuck you\" attitude, it clawed its way into the wild world of cryptocurrency.  Against all odds, the nugget turned into a crypto millionaire, proving that anyone can go from zero to hero. If this discarded piece of shit can make it, so can you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/A8YuMy7y6iyBTUk3qSSkv8ATTJoN2UJTV7X3cb5gpump.png?size=xl&key=db202b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUGGETS>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUGGETS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUGGETS>>(v1);
    }

    // decompiled from Move bytecode v6
}

