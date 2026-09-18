module 0xd4f9aa9eaacb6bcbe978ec1cb94b6089d20fc896bff59fb95db7fdb36064b843::suiszn {
    struct SUISZN has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x4bff617cd7de38e714edc9d1ce3a393f486ca5703ba47320f11e6a62bffdd6bd
    }

    fun init(arg0: SUISZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUISZN>(arg0, 9, 0x1::string::utf8(b"SUISZN"), 0x1::string::utf8(b"Sui Season"), 0x1::string::utf8(b"Sui Season has started!"), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafkreias2hxd2ghgnjoqna4abev323fifntzrmgklpa52qy3rr72vzov6i"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISZN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUISZN>>(0x2::coin_registry::finalize<SUISZN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

