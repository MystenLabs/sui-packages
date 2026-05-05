module 0xb08177ead0b070e98e17bb5e514ddd8c97a60f17976f4e273426bdad2c6b0a17::probot {
    struct PROBOT has drop {
        dummy_field: bool,
    }

    struct BurnCap has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<PROBOT>,
    }

    public fun burn(arg0: &mut BurnCap, arg1: 0x2::coin::Coin<PROBOT>) {
        0x2::coin::burn<PROBOT>(&mut arg0.cap, arg1);
    }

    fun init(arg0: PROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROBOT>(arg0, 9, b"PROBOT", b"Pro-Bot", b"Official Utility and Governance Token for the Pro-Bot AI Trading Ecosystem.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PROBOT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROBOT>>(v1);
        let v3 = BurnCap{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::transfer<BurnCap>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

