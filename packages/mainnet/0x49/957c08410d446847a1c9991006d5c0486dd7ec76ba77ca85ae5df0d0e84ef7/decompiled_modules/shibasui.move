module 0x49957c08410d446847a1c9991006d5c0486dd7ec76ba77ca85ae5df0d0e84ef7::shibasui {
    struct SHIBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBASUI>(arg0, 9, b"SHIBASUI", b"Shiba on Sui", b"Running the Shiba realm on the Base Chain like a boss , one bark at a time !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x041fdf3f472d2c8a7ecc458fc3b7f543e6c57ef7.png?size=lg&key=1c8e0f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIBASUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

