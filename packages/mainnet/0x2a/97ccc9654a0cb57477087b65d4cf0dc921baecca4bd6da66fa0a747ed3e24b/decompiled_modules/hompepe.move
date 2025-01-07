module 0x2a97ccc9654a0cb57477087b65d4cf0dc921baecca4bd6da66fa0a747ed3e24b::hompepe {
    struct HOMPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMPEPE>(arg0, 6, b"HOMPEPE", b"Homer Pepe", x"4a4f494e205448452044274f482d544153544943205245564f4c5554494f4e210a496e7665737420696e2074686520467574757265206f66204d656d65636f696e733a20427579205065706520486f6d657220746f64617920616e642062652070617274206f6620746865206e657874206269672063727970746f2073656e736174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0b0cd1177784287_64dcadf1ae1c6_a8706c860b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

