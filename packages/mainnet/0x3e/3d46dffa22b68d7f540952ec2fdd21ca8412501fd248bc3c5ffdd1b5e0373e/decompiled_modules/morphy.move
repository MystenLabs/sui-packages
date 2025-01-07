module 0x3e3d46dffa22b68d7f540952ec2fdd21ca8412501fd248bc3c5ffdd1b5e0373e::morphy {
    struct MORPHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORPHY>(arg0, 6, b"MORPHY", b"MorphySui", b"Meet MORPHY, the sleepiest member of the group...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/napy_502e586c01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORPHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORPHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

