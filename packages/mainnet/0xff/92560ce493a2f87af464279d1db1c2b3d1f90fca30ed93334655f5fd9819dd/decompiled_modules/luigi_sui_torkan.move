module 0xff92560ce493a2f87af464279d1db1c2b3d1f90fca30ed93334655f5fd9819dd::luigi_sui_torkan {
    struct LUIGI_SUI_TORKAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUIGI_SUI_TORKAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUIGI_SUI_TORKAN>(arg0, 9, b"LUIGI SUI TORKAN", b"LUIGI", b"ES A LUIGI YE YE YE YE BAY THA TUNKAN AND DUN BAR AFRAUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers-clan.com/wp-content/uploads/2024/03/mario-pfp-19.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUIGI_SUI_TORKAN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUIGI_SUI_TORKAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUIGI_SUI_TORKAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

