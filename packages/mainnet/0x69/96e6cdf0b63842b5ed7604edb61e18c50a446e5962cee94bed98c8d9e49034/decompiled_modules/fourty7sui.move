module 0x6996e6cdf0b63842b5ed7604edb61e18c50a446e5962cee94bed98c8d9e49034::fourty7sui {
    struct FOURTY7SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOURTY7SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOURTY7SUI>(arg0, 6, b"Fourty7sui", b"Sui47thpresident", x"546865203437746820507265736964656e7420546f6b656e2c20612067616d652d6368616e67696e672063727970746f63757272656e637920696e73706972656420627920446f6e616c64205472756d70277320756e73746f707061626c6520647269766520616e6420756e7761766572696e672070617373696f6e2e2053657420746f206c61756e6368206f6e207468652053756920436861696e2c207468697320696e6e6f76617469766520746f6b656e20697320706f6973656420746f207265766f6c7574696f6e697a652074686520776f726c64206f662063727970746f63757272656e63792e0a0a54686520343774682050726573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738086519224.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOURTY7SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOURTY7SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

