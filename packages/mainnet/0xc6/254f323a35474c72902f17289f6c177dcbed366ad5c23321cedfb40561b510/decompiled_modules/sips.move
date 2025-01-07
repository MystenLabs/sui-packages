module 0xc6254f323a35474c72902f17289f6c177dcbed366ad5c23321cedfb40561b510::sips {
    struct SIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPS>(arg0, 6, b"SIPS", b"Sips Sui", x"412070726f6a65637420666f72207468652070656f706c652e20596f7572206964656e7469747920696e746f2074686520776f726c64206f6620536970732e0a456d706f776572696e67206469676974616c20746f6765746865726e6573732c206f6e652073697020617420612074696d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z5829326057473_17ce99b8f02b6abc92cb084d4ccf9857_f1e00e3a59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

