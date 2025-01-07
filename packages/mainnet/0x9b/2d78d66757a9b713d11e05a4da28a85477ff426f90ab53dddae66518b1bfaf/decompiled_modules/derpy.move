module 0x9b2d78d66757a9b713d11e05a4da28a85477ff426f90ab53dddae66518b1bfaf::derpy {
    struct DERPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERPY>(arg0, 6, b"DERPY", b"Derpman", b"derpa derpa derpa derpa derpa derpman!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OSL_2k5_Bq_400x400_5852bbb400.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

