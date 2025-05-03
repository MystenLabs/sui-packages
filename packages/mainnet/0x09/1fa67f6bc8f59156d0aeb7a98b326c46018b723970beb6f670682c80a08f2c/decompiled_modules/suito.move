module 0x91fa67f6bc8f59156d0aeb7a98b326c46018b723970beb6f670682c80a08f2c::suito {
    struct SUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITO>(arg0, 6, b"SUITO", b"SuiToto", b"Just a memecoin launched on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigbsjsympfn6ge4o67ghwrmv4nqhzn6lxyc4zu2iyqutau2pks4hq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

