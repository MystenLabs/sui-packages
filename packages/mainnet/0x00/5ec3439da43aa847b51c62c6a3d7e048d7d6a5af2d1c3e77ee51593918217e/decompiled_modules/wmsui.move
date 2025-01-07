module 0x5ec3439da43aa847b51c62c6a3d7e048d7d6a5af2d1c3e77ee51593918217e::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"WaterMan On Sui", b"Meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000332_a840ef2ba0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

