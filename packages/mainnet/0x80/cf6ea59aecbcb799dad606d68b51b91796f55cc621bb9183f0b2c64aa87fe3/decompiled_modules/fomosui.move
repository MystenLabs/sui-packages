module 0x80cf6ea59aecbcb799dad606d68b51b91796f55cc621bb9183f0b2c64aa87fe3::fomosui {
    struct FOMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOSUI>(arg0, 9, b"FOMOSUI", b"FOMO 2.0", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOMOSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

