module 0x6be5707d401165170f3bdfc68b4e32ab595ae8e21c4a51f225a2a58bc1fe8093::mdfk {
    struct MDFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDFK>(arg0, 6, b"MDFK", b"Raydium", b"Never mine pool, launch and make money together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/332_28e439ad1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

