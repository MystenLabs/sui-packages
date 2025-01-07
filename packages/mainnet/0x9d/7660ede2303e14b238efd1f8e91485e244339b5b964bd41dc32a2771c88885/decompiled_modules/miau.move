module 0x9d7660ede2303e14b238efd1f8e91485e244339b5b964bd41dc32a2771c88885::miau {
    struct MIAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAU>(arg0, 6, b"MIAU", b"$SUICAT", b"Enter my way to change the cute life ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000109426_e31962cb98.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

