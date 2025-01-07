module 0x749f06619a78d13a5643c33becb7c33879bda07307e25f2ee34c5c4d7dd839d7::suinke {
    struct SUINKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINKE>(arg0, 6, b"SUINKE", b"SUI PONKE", b"This is Suinke, SUI Ponke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_846ffdf7d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

