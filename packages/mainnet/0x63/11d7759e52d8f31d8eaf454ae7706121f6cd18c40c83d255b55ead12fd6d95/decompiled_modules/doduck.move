module 0x6311d7759e52d8f31d8eaf454ae7706121f6cd18c40c83d255b55ead12fd6d95::doduck {
    struct DODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODUCK>(arg0, 6, b"DODUCK", b"Donald Duck", b"Donald Duck the captain leading Sui next big wave. Limited supply, high energy, and endless quacks. Get on board before this ship leaves the dock.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiec7fl2u5v2qtlb36jq4qtzezmadd2m2nbrd2x24q2jomjakheo7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DODUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

