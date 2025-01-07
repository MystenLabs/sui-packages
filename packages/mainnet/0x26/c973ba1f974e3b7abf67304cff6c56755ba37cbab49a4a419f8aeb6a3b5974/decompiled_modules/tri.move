module 0x26c973ba1f974e3b7abf67304cff6c56755ba37cbab49a4a419f8aeb6a3b5974::tri {
    struct TRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRI>(arg0, 9, b"TRI", b"TRIDENT", x"54726964656e7420546f6b656e0a0a486f6c64657273206f66207468652054726964656e7420546f6b656e2061726520656e766973696f6e65642061732070726f746563746f7273206f6620746865697220636f6d6d756e6974792c20756e6974696e6720756e64657220612073686172656420707572706f7365206f66206e617669676174696e67206368616c6c656e676573207769746820737472656e67746820616e642064657465726d696e6174696f6e2c20656d626f6479696e672074686520756e7969656c64696e6720737069726974206f6620746865206f6365616e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90a76bc9-bcf0-476f-8257-b035182b7b91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

