module 0xca4fa2d75ae3e953724de954c3d562c785c8e982352c8728bee0f4d4bcde44f4::hip {
    struct HIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIP>(arg0, 9, b"HIP", b"HipHip", b"Meme is meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c196465-3719-407b-abf2-ed2b8691e547.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

