module 0x1d37798a3b9c478ddc36a87e2ed23c51ad91a7b3c9f291aa68823c062d2936e::lils {
    struct LILS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILS>(arg0, 6, b"LILS", b"LILCIFERSUI", b"In the middle of the bustling city, the ancient lilac tree stood there, silently witnessing the stories of everyday life. Today, it heard two men talking about \"Suinetwork\" - a strange but mysterious word.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/42_e6a515426e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILS>>(v1);
    }

    // decompiled from Move bytecode v6
}

