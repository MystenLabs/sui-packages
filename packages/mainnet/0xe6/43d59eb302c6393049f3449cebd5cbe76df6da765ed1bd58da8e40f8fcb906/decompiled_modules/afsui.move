module 0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::afsui {
    struct AFSUI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::Safe<0x2::coin::TreasuryCap<AFSUI>>, arg1: &0x2::object::UID, arg2: 0x2::coin::Coin<AFSUI>) : u64 {
        0x2::coin::burn<AFSUI>(0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::borrow_obj_mut<0x2::coin::TreasuryCap<AFSUI>>(arg0, arg1), arg2)
    }

    public fun mint(arg0: &mut 0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::Safe<0x2::coin::TreasuryCap<AFSUI>>, arg1: &0x2::object::UID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AFSUI> {
        0x2::coin::mint<AFSUI>(0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::borrow_obj_mut<0x2::coin::TreasuryCap<AFSUI>>(arg0, arg1), arg2, arg3)
    }

    public fun total_supply(arg0: &0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::Safe<0x2::coin::TreasuryCap<AFSUI>>) : u64 {
        0x2::coin::total_supply<AFSUI>(0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::borrow_obj<0x2::coin::TreasuryCap<AFSUI>>(arg0))
    }

    fun init(arg0: AFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFSUI>(arg0, 9, b"AFSUI", b"afSUI", b"Aftermath Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aftermath.finance/coins/afsui.svg"))), arg1);
        0xe643d59eb302c6393049f3449cebd5cbe76df6da765ed1bd58da8e40f8fcb906::safe::create<0x2::coin::TreasuryCap<AFSUI>>(v0, 0x1::option::none<0x2::object::ID>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

