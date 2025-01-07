module 0x4ce79c9a20ae55e9ad7e396e93f4af0d981404058fb3a76b885c6daddc76e318::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"Ice on Sui", b"First Ice On Sui : https://www.icecoin.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_51_7baf72156a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

