module 0x8a10845fccf551b80dc803f2d52639aef2b626f01f5c647ee0935a814262640c::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"sui brett", x"205355492042524554540a546865207665727920666972737420244272657474206f6e20537569206e6574776f726b0a427265747420697320746865206c6567656e64617279206368617261637465722066726f6d204d6174742046757269657320426f79732720636c756220636f6d69632e20486520686173206265636f6d652074686520626c7565206d6173636f74206f66207468652053756920636861696e2e0a0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039063_8d5769a66f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

