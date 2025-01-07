module 0x1fd3b85680899084e2113a52dc4d17e967d60cdc1d58e29713f3d7f9efe25e24::klspsui {
    struct KLSPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLSPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::create_treasury<KLSPSUI>(arg0, 6, b"klSUI", b"klSUI", b"Kai Leverage SUI Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x9b63ab6504469380567a1730404c491b468ada24a87a72a50e4c2174d29d14e0::init::PoolCreationTicket<0x2::sui::SUI, KLSPSUI>>(0x9b63ab6504469380567a1730404c491b468ada24a87a72a50e4c2174d29d14e0::init::new_pool_creation_ticket<0x2::sui::SUI, KLSPSUI>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLSPSUI>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

