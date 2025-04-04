module 0xa1fefce85b4efafefad994c58bc0553462cf59865c33a4f34353b56adb0e2243::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"LUCE", b"luce", x"546865205661746963616e2068617320756e7665696c656420746865206f6666696369616c206d6173636f74206f66207468650a486f6c795965617220323032353a204c756365286c74616c69616e20666f72204c69676874290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000362_4016d6e1c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

