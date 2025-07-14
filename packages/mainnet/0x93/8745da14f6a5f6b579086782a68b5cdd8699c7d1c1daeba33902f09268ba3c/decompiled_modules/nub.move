module 0x938745da14f6a5f6b579086782a68b5cdd8699c7d1c1daeba33902f09268ba3c::nub {
    struct NUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUB>(arg0, 6, b"Nub", b"Sui Nub Cat", b"nub is a silly cat for the silliest of goobers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicf3zydgkynleikukkja5aciq42xl6bdp267ch2a3a2viffnykg4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

