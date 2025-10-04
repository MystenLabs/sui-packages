module 0x3c0dcd48be065175684db5f435e372faee448eff24452ae0a3f631588e2a2a4b::LOTHZ {
    struct LOTHZ has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOTHZ>, arg1: 0x2::coin::Coin<LOTHZ>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LOTHZ>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOTHZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOTHZ>>(0x2::coin::mint<LOTHZ>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<LOTHZ>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOTHZ>>(arg0);
    }

    fun init(arg0: LOTHZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTHZ>(arg0, 9, b"lothZ", b"SlothZen", b"Moving slow, mooning fast!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68e1a9383bb2f4.34091831.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOTHZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTHZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

