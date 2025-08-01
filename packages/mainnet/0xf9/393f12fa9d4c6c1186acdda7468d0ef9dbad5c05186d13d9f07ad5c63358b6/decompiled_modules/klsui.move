module 0xf9393f12fa9d4c6c1186acdda7468d0ef9dbad5c05186d13d9f07ad5c63358b6::klsui {
    struct KLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x54e96a877b6ed36e953af673efbe82aaa260be3c16a668b4c89b8ee5eb312918::equity::create_treasury<KLSUI>(arg0, 6, b"klSUI", b"klSUI", b"Kai Leverage SUI Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xe06df7f659fa9fd1a4fd002e3844bcbed6cfc81bc72f02a028529c9e860c2503::init::PoolCreationTicket<0x2::sui::SUI, KLSUI>>(0xe06df7f659fa9fd1a4fd002e3844bcbed6cfc81bc72f02a028529c9e860c2503::init::new_pool_creation_ticket<0x2::sui::SUI, KLSUI>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLSUI>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

