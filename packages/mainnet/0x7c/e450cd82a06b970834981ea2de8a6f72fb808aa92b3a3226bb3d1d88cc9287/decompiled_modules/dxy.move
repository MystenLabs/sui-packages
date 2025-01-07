module 0x7ce450cd82a06b970834981ea2de8a6f72fb808aa92b3a3226bb3d1d88cc9287::dxy {
    struct DXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXY>(arg0, 9, b"DXY", b"US Degen Index 6900", b"US Degen Index", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x6900f7b42fb4abb615c938db6a26d73a9afbed69.png?size=lg&key=71f534")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DXY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

