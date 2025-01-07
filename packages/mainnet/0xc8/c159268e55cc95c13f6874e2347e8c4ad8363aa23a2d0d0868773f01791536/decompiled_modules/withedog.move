module 0xc8c159268e55cc95c13f6874e2347e8c4ad8363aa23a2d0d0868773f01791536::withedog {
    struct WITHEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITHEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITHEDOG>(arg0, 6, b"WITHEDOG", b"Withedog Sui", b"#Whitedog the number one dog in memecoin sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053599_fa71fe5718.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITHEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITHEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

