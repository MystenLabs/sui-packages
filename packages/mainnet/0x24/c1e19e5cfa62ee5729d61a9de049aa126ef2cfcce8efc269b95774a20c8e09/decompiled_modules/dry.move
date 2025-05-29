module 0x24c1e19e5cfa62ee5729d61a9de049aa126ef2cfcce8efc269b95774a20c8e09::dry {
    struct DRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRY>(arg0, 6, b"DRY", b"Dry on Sui", b"This is $DRY. A $WET parody created by wet whales. This token is designed to peg to $WET algorithmically. JUST WATCH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigwoaalg4qh4hy7sd7nerrar7ufj4l5qznosfsgltufc7hberavay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

