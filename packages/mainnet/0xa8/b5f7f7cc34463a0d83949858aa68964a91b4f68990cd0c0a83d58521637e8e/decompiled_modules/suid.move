module 0xa8b5f7f7cc34463a0d83949858aa68964a91b4f68990cd0c0a83d58521637e8e::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 6, b"SUID", b"SuiBoom Doge", x"537569426f6f6d20446f676520697320612066756e20616e6420656e676167696e67206d656d6520636f696e206275696c74206f6e207468652053756920626c6f636b636861696e2c2064657369676e656420746f206272696e67206a6f7920616e6420636f6d6d756e6974792073706972697420746f2063727970746f63757272656e637920656e7468757369617374732e204a6f696e20757320696e206f7572206a6f75726e6579206f662067726f77746820616e6420696e6e6f766174696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/33baa9c5_3a13_4276_b70a_3f504e10cb06_6d22dbd374.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

