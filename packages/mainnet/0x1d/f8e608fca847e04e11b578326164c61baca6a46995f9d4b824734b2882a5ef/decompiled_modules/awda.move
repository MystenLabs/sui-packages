module 0x1df8e608fca847e04e11b578326164c61baca6a46995f9d4b824734b2882a5ef::awda {
    struct AWDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWDA>(arg0, 6, b"AWDA", b"AWDAWD", b"awdawd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747048675563.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

