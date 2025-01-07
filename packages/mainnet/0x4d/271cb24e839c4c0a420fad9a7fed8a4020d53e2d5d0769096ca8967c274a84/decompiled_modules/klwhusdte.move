module 0x4d271cb24e839c4c0a420fad9a7fed8a4020d53e2d5d0769096ca8967c274a84::klwhusdte {
    struct KLWHUSDTE has drop {
        dummy_field: bool,
    }

    struct PoolCreationTicket<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::equity::EquityTreasury<T0>,
    }

    public fun create_pool<T0: drop>(arg0: PoolCreationTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let PoolCreationTicket {
            id       : v0,
            treasury : v1,
        } = arg0;
        0x2::object::delete(v0);
        0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::supply_pool::create_pool<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, T0>(v1, arg1)
    }

    fun init(arg0: KLWHUSDTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xb4fae2fd636b996f92234b4d373cc92ce4486e67885d3c314610dd5426504b9::equity::create_treasury<KLWHUSDTE>(arg0, 6, b"klWHUSDTE", b"klWHUSDTE", b"Kai Leverage WHUSDTE Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = PoolCreationTicket<KLWHUSDTE>{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::transfer<PoolCreationTicket<KLWHUSDTE>>(v3, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLWHUSDTE>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

