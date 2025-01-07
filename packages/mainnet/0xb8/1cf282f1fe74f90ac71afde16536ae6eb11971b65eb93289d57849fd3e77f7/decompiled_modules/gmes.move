module 0xb81cf282f1fe74f90ac71afde16536ae6eb11971b65eb93289d57849fd3e77f7::gmes {
    struct GMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMES>(arg0, 6, b"GMES", b"GME on SUI", b"You know Roaring Kitty ???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_WA_Jl_3_F_400x400_74d6ad741b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

