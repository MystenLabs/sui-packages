module 0x4c483233ebf851d888fcd5627bfb9a7d96806ce755c92a86b244380519e92891::zoomer {
    struct ZOOMER has drop {
        dummy_field: bool,
    }

    struct ZOOMERStorage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<ZOOMER>,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<ZOOMER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZOOMER>>(arg0, arg1);
    }

    fun init(arg0: ZOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<ZOOMER>(arg0, v0, b"ZOOMER", b"Zoomer Jack", b"Be like Jack. 0 Tax - No-presale - %90 LP - %2.5 Marketing - %2.5 Community - %2.5 CexList - %2.5 Team.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.seadn.io/gae/2evroZ6mmnyUR7ikIemrX9RLon188XPZykRJLdf4KmZYbq0u-M8-pOUActEvCk4QUYKx4uA1Psbx6EInu9GSY12F_A_VoMFxbfCQ?auto=format&w=1000"))), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ZOOMER>(&mut v3, 1000000 * 0x2::math::pow(10, v0), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOOMER>>(v3, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOOMER>>(v2);
    }

    public fun total_supply(arg0: &ZOOMERStorage) : u64 {
        0x2::balance::supply_value<ZOOMER>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

