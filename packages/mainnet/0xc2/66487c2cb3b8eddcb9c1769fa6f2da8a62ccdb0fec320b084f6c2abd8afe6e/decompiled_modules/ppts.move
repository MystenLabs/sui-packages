module 0xc266487c2cb3b8eddcb9c1769fa6f2da8a62ccdb0fec320b084f6c2abd8afe6e::ppts {
    struct PPTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPTS>(arg0, 6, b"PPTS", b"Peanut Pixel the squirrel", b"His name was - PEANUT. And they killed him, Joe. Killed him like a dog. These are sick people, Joe, theyre sick people. And Peanut was totally innocent. But they killed him like it was nothing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/transferir_3bfada26aa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

