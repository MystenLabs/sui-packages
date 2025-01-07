module 0x27574c4cd54ee1d6a9241ed6fc32c2017f041e0f8e2171118cda04ceb1f91c57::rbp {
    struct RBP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBP>(arg0, 9, b"RBP", b"Rhombus in", b"Rhombus in profit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75c3c4b1-79de-4f79-877d-0fa79b3d1e29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBP>>(v1);
    }

    // decompiled from Move bytecode v6
}

