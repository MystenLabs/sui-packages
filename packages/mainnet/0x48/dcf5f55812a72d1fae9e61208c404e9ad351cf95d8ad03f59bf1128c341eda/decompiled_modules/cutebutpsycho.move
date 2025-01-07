module 0x48dcf5f55812a72d1fae9e61208c404e9ad351cf95d8ad03f59bf1128c341eda::cutebutpsycho {
    struct CUTEBUTPSYCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTEBUTPSYCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CUTEBUTPSYCHO>(arg0, 6, b"CUTEBUTPSYCHO", b"Hilla by SuiAI", b"Funny, cute french bulldog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Naeyttoekuva_2025_01_07_kello_13_37_43_8067f8f322.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUTEBUTPSYCHO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTEBUTPSYCHO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

