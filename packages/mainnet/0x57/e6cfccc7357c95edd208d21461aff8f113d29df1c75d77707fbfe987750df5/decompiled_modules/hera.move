module 0x57e6cfccc7357c95edd208d21461aff8f113d29df1c75d77707fbfe987750df5::hera {
    struct HERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERA>(arg0, 6, b"HERA", b"HERA SUI", x"486572612c206120726567616c206361742c20726f616d7320686572207265616c6d20776974682074686520617574686f72697479206f66206120717565656e2c2077656176696e672074616c6573206f6620776973646f6d20616e6420756e69747920696e206865722077616b652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_21_54_03_799cdc628d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

