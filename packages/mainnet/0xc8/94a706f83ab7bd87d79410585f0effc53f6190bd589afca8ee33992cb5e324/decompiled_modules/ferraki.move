module 0xc894a706f83ab7bd87d79410585f0effc53f6190bd589afca8ee33992cb5e324::ferraki {
    struct FERRAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERRAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERRAKI>(arg0, 6, b"FERRAKI", b"FERRAKISUI", b"THE BEST CAR FOR THE BEST BUYER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_21_b7aa7f07b6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERRAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERRAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

