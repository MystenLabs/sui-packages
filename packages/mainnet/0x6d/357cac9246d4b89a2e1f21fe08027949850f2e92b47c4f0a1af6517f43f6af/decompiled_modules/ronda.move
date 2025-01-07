module 0x6d357cac9246d4b89a2e1f21fe08027949850f2e92b47c4f0a1af6517f43f6af::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"Ronda", b"RondaOnSui", x"4f6666696369616c20746f6b656e206c6976652e0a616c6c20736f6369616c206d65646961206c696e6b20696e2068657265200a68747470733a2f2f6c696e6b74722e65652f726f6e64616f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_0cdb7a8987.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

