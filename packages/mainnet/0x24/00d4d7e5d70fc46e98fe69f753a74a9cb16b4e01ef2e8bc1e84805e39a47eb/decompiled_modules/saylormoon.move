module 0x2400d4d7e5d70fc46e98fe69f753a74a9cb16b4e01ef2e8bc1e84805e39a47eb::saylormoon {
    struct SAYLORMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAYLORMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAYLORMOON>(arg0, 6, b"SAYLORMOON", b"SAYLOR MOON", b"$SAYLOR Token is a meme token created solely for entertainment purposes and has no real-world association with Michael Saylor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016395_e246584205.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAYLORMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAYLORMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

