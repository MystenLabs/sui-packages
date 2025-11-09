module 0x6f6a2cd7b86053349abd66df8ae4e8c8ed100dafb23daa4191989f71384e836b::jew {
    struct JEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEW>(arg0, 6, b"JEW", b"JEWS", b"I hate Jews", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ib_christophwaltzlanda_4825b239b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

