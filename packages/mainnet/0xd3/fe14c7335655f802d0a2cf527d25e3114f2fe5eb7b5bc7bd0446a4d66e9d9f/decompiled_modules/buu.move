module 0xd3fe14c7335655f802d0a2cf527d25e3114f2fe5eb7b5bc7bd0446a4d66e9d9f::buu {
    struct BUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUU>(arg0, 9, b"BUU", b"Buu", b"Buu Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/406268c9-74ef-4d0b-baf6-9da1b36dedbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

