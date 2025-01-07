module 0x2b99fb68610c9b71804711f06124b5dcaf31756096b25f88a44f91e7c7bee233::poop {
    struct POOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOP>(arg0, 9, b"Poop", b"Poop", b"Pooooop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

