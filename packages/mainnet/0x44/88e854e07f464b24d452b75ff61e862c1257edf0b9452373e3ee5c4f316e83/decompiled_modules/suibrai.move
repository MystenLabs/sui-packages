module 0x4488e854e07f464b24d452b75ff61e862c1257edf0b9452373e3ee5c4f316e83::suibrai {
    struct SUIBRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRAI>(arg0, 6, b"SUIBRAI", b"Sui Brain", b"Step into the post-apocalyptic world of Brains, where weak-handed traders become zombies and true survivors hold strong. Will you trade like the undead or outlast the horde like a champion?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul49_20241228215954_06a48ed36c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

