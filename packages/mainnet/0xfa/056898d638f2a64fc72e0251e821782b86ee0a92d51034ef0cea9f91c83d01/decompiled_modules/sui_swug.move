module 0xfa056898d638f2a64fc72e0251e821782b86ee0a92d51034ef0cea9f91c83d01::sui_swug {
    struct SUI_SWUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SWUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SWUG>(arg0, 6, b"Sui_SWUG", b"SWUG", x"5377756720776173206e6f7420616e206f7264696e6172792062756c6c657420f09f92a52e2057697468206120747261696c206f66206d756420616e6420746f6e73206f6620616d626974696f6e20f09f8cb12c206865207370656e74206d6f6e746873207265736561726368696e67206d656d65636f696e7320696e20746865206461726b20756e646572776f726c64206f66207468652063727970746f20756e69762e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731116815072.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_SWUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SWUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

