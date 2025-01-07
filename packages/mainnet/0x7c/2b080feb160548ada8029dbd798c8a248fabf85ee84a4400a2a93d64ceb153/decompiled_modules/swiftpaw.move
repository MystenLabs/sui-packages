module 0x7c2b080feb160548ada8029dbd798c8a248fabf85ee84a4400a2a93d64ceb153::swiftpaw {
    struct SWIFTPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFTPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIFTPAW>(arg0, 6, b"SWIFTPAW", b"SWIFTPAW  ON SUI", x"53776966747061772069732074686520756c74696d617465206d656d65636f696e206f6e20746865205355490a626c6f636b636861696e2c20626c656e64696e6720636f6d6d756e69747920737069726974207769746820706c617966756c0a616476656e747572652e20496e7370697265642062792074686520717569636b20616e6420646172696e670a5377696674706177206368617261637465722c207468697320746f6b656e2061696d7320746f2064656c697665722066756e0a616e642076616c756520746f2069747320686f6c646572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_5_Kx_Vo_C_400x400_aef8cad160.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFTPAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIFTPAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

