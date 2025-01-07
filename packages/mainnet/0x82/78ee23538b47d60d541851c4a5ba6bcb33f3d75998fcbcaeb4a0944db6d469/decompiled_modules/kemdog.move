module 0x8278ee23538b47d60d541851c4a5ba6bcb33f3d75998fcbcaeb4a0944db6d469::kemdog {
    struct KEMDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMDOG>(arg0, 9, b"KEMDOG", b"Kem", b"This is my poodle dog. His name is Kem. He is so cute and active. I live him so much !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21414fd4-1dfc-4ea5-9956-aec5241c1009.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEMDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

