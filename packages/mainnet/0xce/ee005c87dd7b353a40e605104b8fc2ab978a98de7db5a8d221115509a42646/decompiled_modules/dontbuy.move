module 0xceee005c87dd7b353a40e605104b8fc2ab978a98de7db5a8d221115509a42646::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 6, b"Dontbuy", b"DON'T BUY This BUY THE REAL", x"5245414c2043412043544f204c4f4144494e470a3078643034373865653337323030313164393534623665386630386431363030613964666666643534366665636538363264633561626634373030623665316463333a3a7275737369616e7769663a3a5255535349414e574946", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009998_d5f602cbeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

