module 0x23c8427d3008c3399abc8665902140dd011a13bd092e07b24152ef89c88f855d::mmo {
    struct MMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMO>(arg0, 9, b"MMO", b"MOMO", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b813f156-f1fd-48e3-a55b-1670a6ef8da2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

