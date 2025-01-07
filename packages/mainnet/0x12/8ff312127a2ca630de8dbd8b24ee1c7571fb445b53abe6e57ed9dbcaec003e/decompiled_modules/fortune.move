module 0x128ff312127a2ca630de8dbd8b24ee1c7571fb445b53abe6e57ed9dbcaec003e::fortune {
    struct FORTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTUNE>(arg0, 6, b"FORTUNE", b"DemonopolMafia", b"We are here to demonopolize and revolutionize the world has a Mafia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_02_A_17_26_43_cfbcd546_56c2450de0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORTUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

