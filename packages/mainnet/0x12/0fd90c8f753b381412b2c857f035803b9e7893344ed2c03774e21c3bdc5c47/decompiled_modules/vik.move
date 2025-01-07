module 0x120fd90c8f753b381412b2c857f035803b9e7893344ed2c03774e21c3bdc5c47::vik {
    struct VIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIK>(arg0, 6, b"VIK", b"VIKO", x"56696b6f20436f696e207c2046756e204d656574732046696e616e63650a506f77657265642062792074686520636c657665722046656e6e656320466f780a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cls_Ct97_400x400_1_2b0fae1bb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

