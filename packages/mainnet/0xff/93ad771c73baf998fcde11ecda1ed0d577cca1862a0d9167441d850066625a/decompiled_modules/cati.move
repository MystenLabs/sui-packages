module 0xff93ad771c73baf998fcde11ecda1ed0d577cca1862a0d9167441d850066625a::cati {
    struct CATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATI>(arg0, 6, b"Cati", b"Catfroginu", b"Welcome to the jungle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29095_e8f0e24133.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

