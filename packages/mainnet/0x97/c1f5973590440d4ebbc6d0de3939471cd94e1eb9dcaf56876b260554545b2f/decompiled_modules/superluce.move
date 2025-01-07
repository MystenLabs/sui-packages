module 0x97c1f5973590440d4ebbc6d0de3939471cd94e1eb9dcaf56876b260554545b2f::superluce {
    struct SUPERLUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERLUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERLUCE>(arg0, 6, b"SUPERLUCE", b"superluce", x"546865205661746963616e2068617320756e7665696c656420746865206f6666696369616c206d6173636f74206f66207468650a486f6c795965617220323032353a204c756365286c74616c69616e20666f72204c69676874290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000362_6fb90a0743.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERLUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERLUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

