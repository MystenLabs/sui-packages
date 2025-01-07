module 0x311042007ef5354f66fccefc820115b6991fe1da79a1f1587593dba828718b95::hana {
    struct HANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANA>(arg0, 6, b"HANA", b"Hana on Sui", b"Hey there, losers! Im Hana, the ultimate mean girl youve all been waiting for. You probably think Im just some pretty face, but guess what? Im way more than that. Im not here to make friends just profits. So, step aside while I take the throne!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_20_26_11_d221bfdfc8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

