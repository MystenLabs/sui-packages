module 0x8366e44801e61beb8f6ce10e5262048bbf8a7ae57685880049f68ee9e7934c22::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"Chepe", b"Fairlaunch X100", x"446973636f76657220246368657065206f6e207375690a0a466169726c61756e6368206f6e202353554920237375696e6574776f726b20746f6d6f72726f770a0a424153454420444556204c41535420434f494e20326d696c69206d6361700a0a406368657065737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005537_81aed9f861.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

