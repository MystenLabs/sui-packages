module 0x710328cc4d1b57305d46f3ae7f7faf61915be40ec0e05bddc064ce4250bbe14d::bobzi {
    struct BOBZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBZI>(arg0, 6, b"BOBZI", b"Bobzilla On Sui", b"I am Bobzilla try out our volume bot @Suibooster. No TG just vibes. LETS BLOW UP SUI SPACE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifgmaunedwp6jdtsoyaiaajwtxj6bhntqyjf7paixzbtzf22hh6wa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOBZI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

