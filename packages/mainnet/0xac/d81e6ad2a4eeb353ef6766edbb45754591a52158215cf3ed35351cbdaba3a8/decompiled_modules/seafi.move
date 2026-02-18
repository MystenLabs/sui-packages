module 0xacd81e6ad2a4eeb353ef6766edbb45754591a52158215cf3ed35351cbdaba3a8::seafi {
    struct SEAFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAFI>(arg0, 6, b"SFI", b"SeaFI", b"SeaFI Token - Fixed Supply 10M", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SEAFI>>(0x2::coin::mint<SEAFI>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SEAFI>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

