module 0xd4fb2e437fced7e72980f9c6f9a86935b3d3b7f533ef4b3af07a8ce003f80d1d::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<ETH>,
    }

    public fun mint(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ETH> {
        0x2::coin::mint<ETH>(&mut arg0.cap, arg1, arg2)
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<ETH>(arg0, v0, b"ETH", b"ETH", b"Test Ethereum", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<ETH>(&mut v3, 0x2::math::pow(10, v0 + 1), 0x2::tx_context::sender(arg1), arg1);
        let v4 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        0x2::transfer::share_object<Treasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v2);
    }

    // decompiled from Move bytecode v6
}

