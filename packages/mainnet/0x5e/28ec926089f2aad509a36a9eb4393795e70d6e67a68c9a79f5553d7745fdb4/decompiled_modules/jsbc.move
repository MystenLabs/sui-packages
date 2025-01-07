module 0x5e28ec926089f2aad509a36a9eb4393795e70d6e67a68c9a79f5553d7745fdb4::jsbc {
    struct JSBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSBC>(arg0, 6, b"JSBC", b"just sleeping black cat", b"just chilling black cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009405_c3eef8c1ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

