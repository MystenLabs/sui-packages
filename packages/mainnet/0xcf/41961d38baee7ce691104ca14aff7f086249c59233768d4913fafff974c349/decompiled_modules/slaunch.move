module 0xcf41961d38baee7ce691104ca14aff7f086249c59233768d4913fafff974c349::slaunch {
    struct SLAUNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAUNCH>(arg0, 6, b"SLAUNCH", b"Slaunch sui", b"NEW ERA OF DEGEN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6ibtxhmhxjfzrvbvlasshb3tr6p4yxyuztzh6ky7oa63asowhsu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAUNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLAUNCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

