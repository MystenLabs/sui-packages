module 0x598f51d218304b196c68ad7b2f119f12b4017096a28e57c83e74a950736d5022::kingfizs {
    struct KINGFIZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGFIZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGFIZS>(arg0, 6, b"KINGFIZS", b"SUIKINGFIZS", b"King is strong on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreida25edjbi275nolngz5sc3cj4g7xse7xgd5exkhi2efkftbga7ha")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGFIZS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KINGFIZS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

