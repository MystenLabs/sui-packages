module 0xef76e57166411290262c72a812630419636e9afb20903aa47fb1fc8cae6e9402::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"World Liberty Financial", b"We blend traditional finance with blockchain's openness, crafting an easy way to finance that bridges the gap between classic banking and the digital future for all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicwsv7ypcqofbijjqzni6bfr5xvtk2ks2tutffotx7t5x6p7tqiy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WLFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

