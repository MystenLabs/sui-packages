module 0xc0cc0e232359ee8851d6510d3bf80b87da54d5a1716393817287f91d2e4e14c5::m_kyt {
    struct M_KYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_KYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_KYT>(arg0, 9, b"M_KYT", b"Maxicoin", b"A meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f878174-ab86-41ff-a773-54fda51c4ef3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_KYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_KYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

