module 0x1b3726ffdd0e3fbafe883dfaa866d9e58cf1ce9835eaebbc90fe94d4c6c85869::catsdog {
    struct CATSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSDOG>(arg0, 9, b"CATSDOG", b"Catdog", b"Boost your fundz for 50x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbeb121c-068b-4a7c-a90c-6cba9336876d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

