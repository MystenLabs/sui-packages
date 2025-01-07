module 0x1395c125ab46753887ee327a2cde84c934aad8940e3b6d62b630aa9413103e4a::boink12 {
    struct BOINK12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOINK12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOINK12>(arg0, 9, b"BOINK12", b"BOINK", x"5765e280997265206578636974656420746f20616e6e6f756e6365207765e280997665207465616d6564207570207769746820406e6f74706978656c7820f09f96bcefb88f0a0a4a756d7020696e204e4f5720666f722061206368616e636520746f20676574203531322050582066726f6d20706c6179696e6720426f696e6b65727320f09f92a9200a0a4c6574e2809973207365652077686174206b696e64206f6620706978656c7320796f75e280996c6c207061696e74207769746820697420f09f8ea80a0a436865636b206974206f757420686572653a20742e6d652f6e6f74706978656c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06e33113-5641-4538-849e-ed631b06c36a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOINK12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOINK12>>(v1);
    }

    // decompiled from Move bytecode v6
}

