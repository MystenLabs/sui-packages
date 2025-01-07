module 0x7c6b8688b0eaeb46d325135c510e083096dbe9ef3646e22bacd9d497e1814bbe::sunky {
    struct SUNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNKY>(arg0, 6, b"SUNKY", b"Sunkytheduck", b"Welcome to $Suiky ! Suiky is the new quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack quack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037268_4aa79defc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

