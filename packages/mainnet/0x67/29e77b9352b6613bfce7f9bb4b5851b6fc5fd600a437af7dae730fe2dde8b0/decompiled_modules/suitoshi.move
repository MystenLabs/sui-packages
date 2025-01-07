module 0x6729e77b9352b6613bfce7f9bb4b5851b6fc5fd600a437af7dae730fe2dde8b0::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"SUITOSHI", b"Suitoshi", x"427574206e6f7420666f72206c6f6e672e0a0a53424f2069732061626f757420746f20756e6c65617368206120646f63756d656e746172792074686174206d61792066696e616c6c792072657665616c2074686520616e7377657220746f20537569746f7368692773206c6f6e672074696d652068696464656e206964656e746974792e0a0a5265676172646c6573732c20537569746f7368692072656d61696e7320746f206265206f6e65206f6620537569776f726c642773206c6567656e64617279206669677572657320696e2074686520776f726c64206f66205375697970746f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_34_17_c8b5509018.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

