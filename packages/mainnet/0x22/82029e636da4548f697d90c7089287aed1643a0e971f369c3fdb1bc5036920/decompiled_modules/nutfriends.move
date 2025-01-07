module 0x2282029e636da4548f697d90c7089287aed1643a0e971f369c3fdb1bc5036920::nutfriends {
    struct NUTFRIENDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTFRIENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTFRIENDS>(arg0, 6, b"NUTFRIENDS", b"NUTFRIENDS COIN ON SUI", b"Peanut&Friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo400_0077241a0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTFRIENDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTFRIENDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

