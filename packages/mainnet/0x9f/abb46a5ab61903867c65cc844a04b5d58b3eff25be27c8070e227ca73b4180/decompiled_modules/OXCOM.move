module 0x9fabb46a5ab61903867c65cc844a04b5d58b3eff25be27c8070e227ca73b4180::OXCOM {
    struct OXCOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OXCOM>, arg1: 0x2::coin::Coin<OXCOM>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<OXCOM>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OXCOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OXCOM>>(0x2::coin::mint<OXCOM>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<OXCOM>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OXCOM>>(arg0);
    }

    fun init(arg0: OXCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXCOM>(arg0, 9, b"OxCOM", b"Zero Community", b"Zero purpose. Zero accountability. Zero Community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68ea2fd32d9f78.53388690.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OXCOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXCOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

