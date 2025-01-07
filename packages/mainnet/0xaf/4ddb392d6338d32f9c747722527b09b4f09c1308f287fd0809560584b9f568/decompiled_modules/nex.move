module 0xaf4ddb392d6338d32f9c747722527b09b4f09c1308f287fd0809560584b9f568::nex {
    struct NEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEX>(arg0, 9, b"NEX", b"NEXGEN", b"NexGen is a cutting-edge cryptocurrency aimed at revolutionizing digital transactions. Built on advanced blockchain technology, it offers fast, secure, and low-cost payments. Join the future of finance and empower your digital economy with Nex!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ed5e574-3cc0-413d-befd-00c7a02ad523.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

