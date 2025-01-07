module 0xbbf547628508505be67f7c0c23d5e3e09081168d30193c135f920a4cc2858957::ug15 {
    struct UG15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: UG15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UG15>(arg0, 9, b"UG15", b"Kanju", b"The main purpose of this token is to make transaction easy and reduce gas fee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3d98b76-a9c3-4ef0-b51e-d7dc9e5d7710.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UG15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UG15>>(v1);
    }

    // decompiled from Move bytecode v6
}

