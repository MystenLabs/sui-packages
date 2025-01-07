module 0x6b42e2f4cd5b74c737258b3589a3a09397bb012bda6183f99a87294ecaa8504e::capo {
    struct CAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 9, b"CAPO", b"Capo The Mafia ", x"4361706f206973206f6e65206f66207468652066697273742070726f6a65637473206f6620376b46554e2e20417320746865206669727374206d616669612d7468656d6564206d656d65636f696e206f6e2074686520537569206e6574776f726b2c204361706f20696e766974657320796f7520746f206a6f696e207468652066616d696c7920616e642062652070617274206f662069747320626f6c64206a6f75726e657920746f20646f6d696e617465207468652065636f73797374656d210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0b0a84fee104a06b0eb71fc437e0cae7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

