module 0xebe103d8de7b15108b59360a00cb1b9b30c0a538ed2c3faef77ae136729aed3a::landwu {
    struct LANDWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LANDWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LANDWU>(arg0, 6, b"LANDWU", b"LANDWU ON SUI", x"4c414e4457552049532054484520414c5445522045474f204f4620594f55520a4641564f5249544520424f595320434c554220434841524143544552204c414e44574f4c46", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6689c0a8e522309ba71d8106_Land_Wu_X_PFP_402x_copy_2_b1dafb4657.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LANDWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LANDWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

