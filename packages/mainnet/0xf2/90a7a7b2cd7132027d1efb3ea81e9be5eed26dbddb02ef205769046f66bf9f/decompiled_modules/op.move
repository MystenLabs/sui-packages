module 0xf290a7a7b2cd7132027d1efb3ea81e9be5eed26dbddb02ef205769046f66bf9f::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OP>(arg0, 9, b"OP", b"jh", b"SG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c5e3def-e1f9-4efe-9425-d47e19ad7a4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OP>>(v1);
    }

    // decompiled from Move bytecode v6
}

