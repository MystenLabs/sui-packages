module 0x72d8289353c47b048949425bc1936f83fe2283cc19cd883d8f314e907a44e4a3::neural {
    struct NEURAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEURAL>(arg0, 6, b"NEURAL", b"Neural AI by SuiAI", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dnge_Ne_KV_400x400_7f6df00b3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEURAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

