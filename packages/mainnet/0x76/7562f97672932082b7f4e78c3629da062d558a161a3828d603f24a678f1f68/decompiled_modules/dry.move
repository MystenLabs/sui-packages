module 0x767562f97672932082b7f4e78c3629da062d558a161a3828d603f24a678f1f68::dry {
    struct DRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRY>(arg0, 6, b"DRY", b"Dry on Sui", b"This is $DRY, the $WET parody created by $WET whales. This token is designed to peg to $WET algorithmically. Just a $DRY, well not so dry.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigwoaalg4qh4hy7sd7nerrar7ufj4l5qznosfsgltufc7hberavay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

