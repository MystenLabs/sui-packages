module 0x71946e2dd520c12263fed61f5fa852c44914916d0ee18c4ed238f8446712f0b5::LOFI {
    struct LOFI has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::mint<LOFI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 9, b"LOFI", b"LOFI", b"Lofi is everyone's favorite Yeti on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fM8QZXh/LOFI-PFP.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::mint<LOFI>(&mut v2, 1000000000000000000, arg1), @0x652fdc51273a2874ad00dc929cc57789810766344eb7c9a722499ccc7eb4763c);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_from(arg0: &AdminCap, arg1: &mut 0x2::coin::Coin<LOFI>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::split<LOFI>(arg1, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

