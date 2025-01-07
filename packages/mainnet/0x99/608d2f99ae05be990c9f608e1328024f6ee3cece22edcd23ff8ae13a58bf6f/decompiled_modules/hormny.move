module 0x99608d2f99ae05be990c9f608e1328024f6ee3cece22edcd23ff8ae13a58bf6f::hormny {
    struct HORMNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORMNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORMNY>(arg0, 6, b"HORMNY", b"HORMNY SUI", b"Here to shake up and sparkle the meme coin market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_D2_Vrg_Oo_400x400_0076f50102.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORMNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORMNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

