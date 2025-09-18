module 0x3a5a0876476e6e93d9e8c77fc763f295274f73ea651f10eaa64979eb093ee17b::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BTC>,
    }

    public fun mint(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BTC> {
        0x2::coin::mint<BTC>(&mut arg0.cap, arg1, arg2)
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 8;
        let (v1, v2) = 0x2::coin::create_currency<BTC>(arg0, v0, b"BTC", b"BTC", b"Test Bitcoin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<BTC>(&mut v3, 0x1::u64::pow(10, v0), 0x2::tx_context::sender(arg1), arg1);
        let v4 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v3,
        };
        0x2::transfer::share_object<Treasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v2);
    }

    // decompiled from Move bytecode v6
}

