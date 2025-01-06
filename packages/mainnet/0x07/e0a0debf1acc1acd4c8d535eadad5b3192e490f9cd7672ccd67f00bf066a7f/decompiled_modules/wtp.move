module 0x7e0a0debf1acc1acd4c8d535eadad5b3192e490f9cd7672ccd67f00bf066a7f::wtp {
    struct WTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTP>(arg0, 9, b"WTP", b"walrus TGE pass", x"77616c727573205447452070617373e38080", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c4e685df9a9e4a2bfeab51f7157b0392blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

