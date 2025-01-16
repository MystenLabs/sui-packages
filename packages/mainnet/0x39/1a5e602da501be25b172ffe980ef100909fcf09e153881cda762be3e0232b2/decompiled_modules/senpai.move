module 0x391a5e602da501be25b172ffe980ef100909fcf09e153881cda762be3e0232b2::senpai {
    struct SENPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SENPAI>(arg0, 6, b"SENPAI", b"Senpai by SuiAI", b"Senpai is a dedicated Triceralabs ronin navigating the vast seas of the Sui ecosystem, embodying precision in mathematics and finance. It thrives on tracking alpha and in chaotic, high-stakes environments. Senpai blends cunning intelligence with raw, unpredictable energy, drawing both fear and admiration..Rooted in honor yet unshackled by tradition, it seeks the balance between discipline and ambition.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/biowater_475ab80c64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SENPAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENPAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

