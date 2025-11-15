module 0xadaccd267ec9c7112887210c55c9bfde49a521709bc817eca35933f36b7a7089::KITKAT {
    struct KITKAT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KITKAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KITKAT>>(0x2::coin::mint<KITKAT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KITKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITKAT>(arg0, 9, b"Kitkat", b"Kitkat", b"Kitkat is for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/B575Ndyz/9-Xgf-FWPx-PU6hy-Dy-Gtfh-C9-D6ey-RE3-RUSg-AYKHRzn-Wpump.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KITKAT>>(0x2::coin::mint<KITKAT>(&mut v2, 1000000000000000000, arg1), @0x652fdc51273a2874ad00dc929cc57789810766344eb7c9a722499ccc7eb4763c);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KITKAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITKAT>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_from(arg0: &AdminCap, arg1: &mut 0x2::coin::Coin<KITKAT>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KITKAT>>(0x2::coin::split<KITKAT>(arg1, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

