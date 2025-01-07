module 0x88818bc1aa80c1fa439e50bb9d956bfd23d28a81a2ea4ea5cef016c34b5af487::yingae {
    struct YINGAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YINGAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YINGAE>(arg0, 6, b"YINGAE", b"YING=GAE", x"59696e67206973204761652e204761652069732059696e672e200a5468652062616c616e6365206265747765656e2047616520616e642059696e6720697320537569776565742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033239_cd208fd8d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YINGAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YINGAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

