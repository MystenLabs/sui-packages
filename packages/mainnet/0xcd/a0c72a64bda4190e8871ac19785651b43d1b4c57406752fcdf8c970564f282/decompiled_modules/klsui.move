module 0xcda0c72a64bda4190e8871ac19785651b43d1b4c57406752fcdf8c970564f282::klsui {
    struct KLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::equity::create_treasury<KLSUI>(arg0, 6, b"klSUI", b"klSUI", b"Kai Leverage SUI Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xfa101048aa5f13870111a1030db5cae049722dfe640122a3dfc80013ab41367f::init::PoolCreationTicket<0x2::sui::SUI, KLSUI>>(0xfa101048aa5f13870111a1030db5cae049722dfe640122a3dfc80013ab41367f::init::new_pool_creation_ticket<0x2::sui::SUI, KLSUI>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLSUI>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

