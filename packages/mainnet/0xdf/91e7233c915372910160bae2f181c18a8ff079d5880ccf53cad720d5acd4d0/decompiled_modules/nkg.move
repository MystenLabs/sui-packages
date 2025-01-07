module 0xdf91e7233c915372910160bae2f181c18a8ff079d5880ccf53cad720d5acd4d0::nkg {
    struct NKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKG>(arg0, 9, b"NKG", b"NICEKING", b"MY WEWE 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0385db18-e103-412f-80ad-4bb64d48477f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

