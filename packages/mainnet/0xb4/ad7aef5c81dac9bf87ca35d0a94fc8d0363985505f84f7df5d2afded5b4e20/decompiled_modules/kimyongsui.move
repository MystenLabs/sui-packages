module 0xb4ad7aef5c81dac9bf87ca35d0a94fc8d0363985505f84f7df5d2afded5b4e20::kimyongsui {
    struct KIMYONGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMYONGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMYONGSUI>(arg0, 6, b"KIMYONGSUI", b"Kim Jong sui", b"Sui on dictator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031393_bfcafd2e30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMYONGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMYONGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

