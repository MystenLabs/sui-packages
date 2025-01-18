module 0x3eb9c1938cbf9c04fd622425ece57eecd5c5924ca22d3a19b59de196a920a5e::kimj {
    struct KIMJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMJ>(arg0, 6, b"KIMJ", b"Kim Jung Un", b"Trump ? F*ck it. Here it is : the official Kim Jung Un token, on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kimjun_4fde01b450.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

