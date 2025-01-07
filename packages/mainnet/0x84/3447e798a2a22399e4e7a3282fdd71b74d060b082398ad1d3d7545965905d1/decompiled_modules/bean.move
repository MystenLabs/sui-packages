module 0x843447e798a2a22399e4e7a3282fdd71b74d060b082398ad1d3d7545965905d1::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 9, b"BEAN", b"Mr Bean", x"5468697320746f6b656e2069732064656469636174656420746f20746865206775792077686f206d616465206f7572206368696c64686f6f6420617765736f6d6520f09fa5b9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54a9aaef-d9db-42bd-943b-16536429b2bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

