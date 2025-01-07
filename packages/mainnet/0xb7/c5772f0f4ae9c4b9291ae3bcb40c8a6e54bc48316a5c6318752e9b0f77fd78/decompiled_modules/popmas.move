module 0xb7c5772f0f4ae9c4b9291ae3bcb40c8a6e54bc48316a5c6318752e9b0f77fd78::popmas {
    struct POPMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPMAS>(arg0, 9, b"POPMAS", b"Popmas", b"Happy $POPMAS - POP POP POP POP POP POP POP POP POP POP POP POP POP POP POP POP POP POP POP POP POP  POP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreigiykahc6bw3qm7xfvi2m6fxerztdh5ciltb2qnvkdec2vca5qwwe.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPMAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPMAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

