module 0x2d328e53e26c0a77bcb2ae2fae9cccf14186f8be34f6590c4edf3e2ca950f3e7::jaws {
    struct JAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWS>(arg0, 9, b"JAWS", b"jabberJAWS", b"The hero who enchanted generations in the past will enchant in the future. $JAWS_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1f4f560-056b-4249-b5fc-03566dba1a08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

