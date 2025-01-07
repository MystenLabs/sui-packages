module 0x54933c39eec7c3b1bbd20fa243f1e7337edb348dfcd09a3cefab791534f7e2d0::memeco {
    struct MEMECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECO>(arg0, 9, b"MEMECO", b"MeMeCoin", b"miloo miloo trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dc58a4a-059d-446b-93fb-becf6dac3899.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

