module 0xabafc12c0412aedafc17659be015f87368a9548b099b8d62bd0fb381ce4fdd1b::kdb {
    struct KDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDB>(arg0, 9, b"KDB", b"Kevin", b"Kevin De Bruyne", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2a12c46-16ac-4f21-9715-998e2117220c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

