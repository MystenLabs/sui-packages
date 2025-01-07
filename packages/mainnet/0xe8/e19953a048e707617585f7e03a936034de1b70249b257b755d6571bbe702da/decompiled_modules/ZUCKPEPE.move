module 0xe8e19953a048e707617585f7e03a936034de1b70249b257b755d6571bbe702da::ZUCKPEPE {
    struct ZUCKPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCKPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCKPEPE>(arg0, 9, b"ZUCKPEPE", b"ZUCKPEPE", b"Introducing the ZUCKPEPE, a meme cute that builds upon the resounding success of ZUCKPEPE on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1676827939776892928/L12jszX4_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUCKPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCKPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZUCKPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZUCKPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

