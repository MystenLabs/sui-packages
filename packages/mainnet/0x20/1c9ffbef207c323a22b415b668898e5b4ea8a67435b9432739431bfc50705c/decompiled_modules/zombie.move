module 0x201c9ffbef207c323a22b415b668898e5b4ea8a67435b9432739431bfc50705c::zombie {
    struct ZOMBIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMBIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMBIE>(arg0, 6, b"Zombie", b"Sui Zombie", b"The undead has risen on Sui! With the ticker $ZOMBIE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zombie_a50a02f38d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMBIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMBIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

