module 0xb49444289c073fec756621a24fdfbc8c6be6a2ea11b14ab4cc382e83fd90458c::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST>(arg0, 9, 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"TEST"), 0x1::string::utf8(b"G"), 0x1::string::utf8(b"https://gateway.irys.xyz/RqW_xzdtIYrWe8S0mcRW68L24yOIUM4WsD6cD2DaS2U"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::coin_registry::make_supply_fixed_init<TEST>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TEST>(v3, arg1);
    }

    // decompiled from Move bytecode v7
}

