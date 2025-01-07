module 0x4e737013a7daa94b9d5f8b6c81583858ae97d724f0218ad06035123cbc9c35a1::vnn {
    struct VNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNN>(arg0, 9, b"VNN", b"Fg", b"Bnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecd90bc6-a314-45cf-a3c8-e51f4804ef7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

