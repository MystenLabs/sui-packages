module 0xe2e1d8b1c079ee0ad42b2dd361bde68eed90929eac579a41ff9d6877cfd88a19::orgosui {
    struct ORGOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGOSUI>(arg0, 6, b"ORGOsui", b"ocean gorilla sui", x"4f52474f20737569206120756e69717565206d656d650a0a224469766520696e746f2063727970746f207269636865732077697468204f6365616e20476f72696c6c612120244f52474f20746f6b656e2c207468652074726561737572652d6b656570696e67206b696e67206f6620746865206f6365616e2773206465707468732c207969656c64732061717561746963206162756e64616e636521220a0a5765277265206c61756e6368696e67206f6e206d6f766570756d70206f6e20547565736461792077652077696c6c20616e6e6f756e6365207468652074696d6520736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241029_114233_1_de7cfb4571.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORGOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

