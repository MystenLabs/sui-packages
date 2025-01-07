module 0x8e9827ef1d32deaeaf7d7935fcaa2dd75a33b188dafa67aa05172f6ea2a27d69::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY>(arg0, 6, b"BABY", b"Baby Sui", b"The cutes Coin on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qbwx_Xe_Yh_400x400_36a1859c9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

