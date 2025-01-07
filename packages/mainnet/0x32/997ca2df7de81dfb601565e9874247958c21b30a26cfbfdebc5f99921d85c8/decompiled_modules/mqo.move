module 0x32997ca2df7de81dfb601565e9874247958c21b30a26cfbfdebc5f99921d85c8::mqo {
    struct MQO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MQO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MQO>(arg0, 9, b"MQO", b"mosquito", b"fly up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ced98013-039e-4faa-8661-b8ac6f8fd322.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MQO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MQO>>(v1);
    }

    // decompiled from Move bytecode v6
}

