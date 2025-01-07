module 0x73afc146c80555810aa0a9096aa737959605763be37ed97b4ceddc45bc49d367::fgsui {
    struct FGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGSUI>(arg0, 6, b"FGSUI", b"FOMOGuy", b"Why FOMO when you can just buy $FGSUI  early and watch your bag moon. Thats what FOMOGuy does", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5449_f8e95ea13e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

