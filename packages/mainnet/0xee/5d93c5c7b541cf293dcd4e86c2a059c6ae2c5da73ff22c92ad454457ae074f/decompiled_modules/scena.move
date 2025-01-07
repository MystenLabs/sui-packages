module 0xee5d93c5c7b541cf293dcd4e86c2a059c6ae2c5da73ff22c92ad454457ae074f::scena {
    struct SCENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCENA>(arg0, 6, b"SCena", b"SuiCena", b"Release movepump coins, take snapshots of all holders, and continue to airdrop cena limited NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/WX_20240925_112354_2x_5312f16222.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

