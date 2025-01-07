module 0x852e253132415bb43f6f798ca65d7fa11c702bffe92b8a65534bf4e825bf25b::xushizhao_coin {
    struct XUSHIZHAO_COIN has drop {
        dummy_field: bool,
    }

    struct MyCoinTreasuryCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<XUSHIZHAO_COIN>,
    }

    public entry fun getCoin() {
        let v0 = 1;
        0x1::debug::print<u8>(&v0);
    }

    fun init(arg0: XUSHIZHAO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUSHIZHAO_COIN>(arg0, 9, b"xuCoin", b"xushizhao Coin", b"My first Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUSHIZHAO_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XUSHIZHAO_COIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XUSHIZHAO_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XUSHIZHAO_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

