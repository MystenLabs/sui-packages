module 0x13a82bbc202d2e99c7c31289eea32f02f517f7d53a68521b500cdc9d48c28af9::olymcat {
    struct OLYMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLYMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLYMCAT>(arg0, 6, b"OLYMCAT", b"SUI OLYMCAT", b"Olymcat Inspired by the spirit of the Olympics, Olymcat embodies excellence, friendship, and respect. Just like the Olympics unites people from around the world, Olymcat brings together a global community of crypto enthusiasts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042639_9c1e15a00d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLYMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLYMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

