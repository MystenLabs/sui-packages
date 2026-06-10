module 0x1f70ba166dd2635ee9d41433aa040c96ce541100ef3637c2d573284f3fab9d2a::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BTC>, arg1: 0x2::coin::Coin<BTC>) {
        0x2::coin::burn<BTC>(arg0, arg1);
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 9, b"BTC", b"Bitcoin", b"Custom SUI Token: Bitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/bitcoin-btc-logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<BTC>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTC>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

