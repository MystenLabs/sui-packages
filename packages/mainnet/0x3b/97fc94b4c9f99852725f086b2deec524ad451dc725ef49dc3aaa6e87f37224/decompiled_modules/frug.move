module 0x3b97fc94b4c9f99852725f086b2deec524ad451dc725ef49dc3aaa6e87f37224::frug {
    struct FRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUG>(arg0, 6, b"FRUG", b"Sui Frug", b"This is $FRUG. He is professional frog, has all the sthrengths and no weakness. Have a deal now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_17_57_53_ae96498d5a_efd8c88d1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

