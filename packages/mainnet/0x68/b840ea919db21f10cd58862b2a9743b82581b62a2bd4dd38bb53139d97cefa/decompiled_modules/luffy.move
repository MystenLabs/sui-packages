module 0x68b840ea919db21f10cd58862b2a9743b82581b62a2bd4dd38bb53139d97cefa::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 6, b"LUFFY", b"STRAWHAT", b"The King of pirates is now sailing in the sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_2386e7066c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

