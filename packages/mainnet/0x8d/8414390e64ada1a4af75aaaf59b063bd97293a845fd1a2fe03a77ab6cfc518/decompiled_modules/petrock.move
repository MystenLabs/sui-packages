module 0x8d8414390e64ada1a4af75aaaf59b063bd97293a845fd1a2fe03a77ab6cfc518::petrock {
    struct PETROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETROCK>(arg0, 6, b"PETROCK", b"PETROCKONSUI", b"the original no-maintenance pet $PETROCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_Bm_H_Xagb_400x400_c36719d7c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

