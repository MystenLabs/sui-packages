module 0x7a8552b90716abd23f2e3ee438c596b16058fd4a0a42cef38097f2e570bd8f44::babyluce {
    struct BABYLUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYLUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYLUCE>(arg0, 6, b"BABYLUCE", b"babyluce", x"546865205661746963616e2068617320756e7665696c656420746865206f6666696369616c206d6173636f74206f66207468650a486f6c795965617220323032353a204c756365286c74616c69616e20666f72204c69676874290a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000362_0f933ad1dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYLUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYLUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

