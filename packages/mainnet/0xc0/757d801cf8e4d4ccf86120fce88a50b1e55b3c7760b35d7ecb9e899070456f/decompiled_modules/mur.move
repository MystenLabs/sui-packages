module 0xc0757d801cf8e4d4ccf86120fce88a50b1e55b3c7760b35d7ecb9e899070456f::mur {
    struct MUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUR>(arg0, 9, b"MUR", b"Murzik", x"4d75727a696b206d656d6520746f6b656e212121f09f9088e2808de2ac9b20546865206d6f6e65792049206561726e2077696c6c20676f20746f776172647320666f6f6420666f72206d79206361742120476f20746f20746865206d6f6f6e212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20d972da-e58f-4d09-8d0c-123c6b13a112.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

