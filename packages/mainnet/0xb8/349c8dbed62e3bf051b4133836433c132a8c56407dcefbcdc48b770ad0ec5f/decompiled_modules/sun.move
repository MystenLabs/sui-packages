module 0xb8349c8dbed62e3bf051b4133836433c132a8c56407dcefbcdc48b770ad0ec5f::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUN>, arg1: 0x2::coin::Coin<SUN>) {
        assert!(false == false, 100);
        0x2::coin::burn<SUN>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<SUN>(0x2::coin::supply<SUN>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SUN>>(0x2::coin::mint<SUN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 2, b"SUN", b"sunflowers ", b"ray of sunshine in flower form", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/G7D9nLJAnPn9u-Da4AK6teI-DhNos91PxmgW82sUFAQ?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

