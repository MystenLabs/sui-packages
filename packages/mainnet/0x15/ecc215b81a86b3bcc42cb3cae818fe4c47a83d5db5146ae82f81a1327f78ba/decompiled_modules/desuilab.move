module 0x15ecc215b81a86b3bcc42cb3cae818fe4c47a83d5db5146ae82f81a1327f78ba::desuilab {
    struct DESUILAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESUILAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESUILAB>(arg0, 6, b"Desuilab", b"DeSuiLabs", b"Degenerates running experiments on the Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/desuilabs_672744457e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESUILAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESUILAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

