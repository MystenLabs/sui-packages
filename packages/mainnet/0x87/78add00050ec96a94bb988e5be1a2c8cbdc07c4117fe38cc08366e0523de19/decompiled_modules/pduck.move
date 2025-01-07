module 0x8778add00050ec96a94bb988e5be1a2c8cbdc07c4117fe38cc08366e0523de19::pduck {
    struct PDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDUCK>(arg0, 9, b"PDuck", b"Pirate Duck", b"Pirate Duck is a fun and quirky game where players control a group of pirate ducks sailing across dangerous seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co.com/8KW7VtC/Pirate-rubber-duck-580x386.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PDUCK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

