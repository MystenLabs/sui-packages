module 0xe9e8bc117b6f1e1e3f80fda6b6d7eba617322d3a5595562089517d41e63fc164::team {
    struct TEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEAM>(arg0, 6, b"TEAM", b"Sui Pokemon Team", x"506f6bc3a96d6f6e20696e7370697265732066616e7320776f726c647769646520746f20656d6261726b206f6e206570696320616476656e7475726573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihl3sajkrmvadnmu3yywul4xysiqsoboexc6aiadc3bscwvpq3owu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

