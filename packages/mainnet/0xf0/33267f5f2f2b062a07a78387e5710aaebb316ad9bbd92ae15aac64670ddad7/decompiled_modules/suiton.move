module 0xf033267f5f2f2b062a07a78387e5710aaebb316ad9bbd92ae15aac64670ddad7::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"Water Release", x"0a57617465722052656c656173652028537569746f6e29206973206f6e65206f662074686520626173696320656c656d656e74616c206e6174757265207472616e73666f726d6174696f6e20746563686e6971756573207468617420616c6c6f7720746865207573657220746f206d616e6970756c617465207072652d6578697374696e672077617465722c206f7220637265617465207468656972206f776e2c206279207475726e696e67207468656972206368616b726120696e746f207761746572207375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_17_39_28_ec52886070.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITON>>(v1);
    }

    // decompiled from Move bytecode v6
}

