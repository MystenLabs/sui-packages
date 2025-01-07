module 0xffd93f051de9c72cade34a9dbd10bbaf9b339804ac710e057658e1bcd975eb07::sobama {
    struct SOBAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOBAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOBAMA>(arg0, 6, b"SOBAMA", b"Sui Obama", b"Why Obama wif blue hair? Because its fucking Sui Obama!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031307_1638f3dabe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOBAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOBAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

