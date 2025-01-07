module 0xcd2c2c491dad56bf89888d55e1237f3703a0215a7bf384724f939ec80840b44f::groggi {
    struct GROGGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGI>(arg0, 6, b"GROGGI", b"GROGGI ON SUI", b"GROGGI IS BACK TO TAKE PUSH ON A SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Copy_of_43e9fa_764e21e449.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

