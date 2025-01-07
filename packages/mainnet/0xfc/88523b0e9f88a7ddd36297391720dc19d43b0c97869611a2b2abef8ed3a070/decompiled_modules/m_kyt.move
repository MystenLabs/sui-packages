module 0xfc88523b0e9f88a7ddd36297391720dc19d43b0c97869611a2b2abef8ed3a070::m_kyt {
    struct M_KYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_KYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_KYT>(arg0, 9, b"M_KYT", b"Maxicoin", b"A meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d397b44-e8f6-423f-aeb4-138ac861bdfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_KYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_KYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

