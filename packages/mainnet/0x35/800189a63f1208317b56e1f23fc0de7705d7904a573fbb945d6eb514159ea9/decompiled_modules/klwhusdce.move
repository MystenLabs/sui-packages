module 0x35800189a63f1208317b56e1f23fc0de7705d7904a573fbb945d6eb514159ea9::klwhusdce {
    struct KLWHUSDCE has drop {
        dummy_field: bool,
    }

    struct PoolCreationTicket<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::EquityTreasury<T0>,
    }

    public fun create_pool<T0: drop>(arg0: PoolCreationTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let PoolCreationTicket {
            id       : v0,
            treasury : v1,
        } = arg0;
        0x2::object::delete(v0);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::create_pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, T0>(v1, arg1)
    }

    fun init(arg0: KLWHUSDCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::create_treasury<KLWHUSDCE>(arg0, 6, b"klWHUSDCE", b"klWHUSDCE", b"Kai Leverage WHUSDCE Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = PoolCreationTicket<KLWHUSDCE>{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::transfer<PoolCreationTicket<KLWHUSDCE>>(v3, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLWHUSDCE>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

