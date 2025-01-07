module 0x4f83caf6626d0f931ac519028e62a8f9d9fc8fdf62da09489023940fd0bba882::sqid {
    struct SQID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQID>(arg0, 6, b"SQID", b"SquidOnSui", b"Squid on Sui BlockChain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4469_aba274c6ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQID>>(v1);
    }

    // decompiled from Move bytecode v6
}

