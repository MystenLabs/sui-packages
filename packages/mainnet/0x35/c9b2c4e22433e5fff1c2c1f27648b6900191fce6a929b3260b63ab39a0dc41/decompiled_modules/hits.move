module 0x35c9b2c4e22433e5fff1c2c1f27648b6900191fce6a929b3260b63ab39a0dc41::hits {
    struct HITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HITS>(arg0, 9, b"HITS", b"Hits", b"Sebuah token yang akan pump sangat hits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8ed56a4-8425-439c-a86d-9883c1e6e3ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

