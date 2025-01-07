module 0x1624e23ff146027e42be525b3172bb01373c64b2206635a7a0f3479012a5bce0::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"Luce", b"luce", x"546865205661746963616e2068617320756e7665696c656420746865206f6666696369616c206d6173636f74206f66207468650a486f6c795965617220323032353a204c756365286c74616c69616e20666f72204c69676874290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731074038794.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

