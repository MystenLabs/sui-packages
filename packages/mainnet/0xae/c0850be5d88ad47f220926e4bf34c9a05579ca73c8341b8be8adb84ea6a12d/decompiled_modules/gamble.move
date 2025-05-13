module 0xaec0850be5d88ad47f220926e4bf34c9a05579ca73c8341b8be8adb84ea6a12d::gamble {
    struct GAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMBLE>(arg0, 6, b"Gamble", b"Gamble (God Mod)", x"31303078204f72204e6f7468696e670a546869732069732047414d424c45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifaahu24k2gr77fsejiwtxqmhwoobyszqcl3acsnvddumhho7vhai")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAMBLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

