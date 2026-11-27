module 0xb88277df4619c737f7df675a9504109446f59dd4672828632484f870a622b693::uds {
    struct UDS has drop {
        dummy_field: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: UDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDS>(arg0, 9, b"UDS", b"UDS Stable", b"UDS stablecoin: 1 UDS = 1 USDC. Fixed supply, no mint authority.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.klife.world/logos/uds.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UDS>>(0x2::coin::mint<UDS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = Vault{id: 0x2::object::new(arg1)};
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Supply<UDS>>(&mut v3.id, b"locked_supply", 0x2::coin::treasury_into_supply<UDS>(v2));
        0x2::transfer::share_object<Vault>(v3);
    }

    // decompiled from Move bytecode v7
}

