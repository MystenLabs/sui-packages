module 0xdd20f87bea1c8aab1f2291be39e694e6ff5d8339de5115bfa6012890baf88178::sunshine {
    struct SUNSHINE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUNSHINE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUNSHINE>>(0x2::coin::mint<SUNSHINE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUNSHINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNSHINE>(arg0, 9, b"SHINE", b"SUNSHINE", b"Sunshine a meme travelled from 1900s to present time looking to free it self into the sui blockchain with expectation of an Ai agent doing the work.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1866988062309310464/p-aETv7i_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUNSHINE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNSHINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNSHINE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

