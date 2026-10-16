module 0x8373750b862538f336e58b9829608e8d5e301efe52d0020ff04a59b041bcfe1c::suigo {
    struct SUIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIGO>(arg0, 6, 0x1::string::utf8(b"SUIGO"), 0x1::string::utf8(b"penguin"), 0x1::string::utf8(b"The penguin is sad and wants to go back."), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/NITpJQJypjkchGNg9Zc0hRJuHHXwnsV14rOWAjTY2OYBAQBVAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUIGO>>(0x2::coin_registry::finalize<SUIGO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

