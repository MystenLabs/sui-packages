module 0x25e36fce1cf758fe9cc8a352b3c202bb0595942825aa260fe4aa8b9554b39bbd::popy {
    struct POPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPY>(arg0, 6, b"POPY", b"Poppy", x"4d65657420506f7070792c207468652066697273742061646f7261626c652063617420746f20677261636520746865204d656d652053756920436861696e2120506f70707920697320612064656c6967687466756c206469676974616c2066656c696e652c20636170747572696e672068656172747320616e6420737072656164696e6720736d696c6573207468726f7567686f75742074686520626c6f636b636861696e20636f6d6d756e6974792e200a4a6f696e207468652066756e207769746820506f70707920616e6420696d6d6572736520796f757273656c6620696e206120636f6d6d756e6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731448490466.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

