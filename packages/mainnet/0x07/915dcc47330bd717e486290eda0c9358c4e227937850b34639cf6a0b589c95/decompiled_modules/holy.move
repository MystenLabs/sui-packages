module 0x7915dcc47330bd717e486290eda0c9358c4e227937850b34639cf6a0b589c95::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY>(arg0, 9, b"HOLY", b"HOLY token", b"For Individuals who are living in a Christ like manner who can also share same crypto goals can be brought together by HOLY token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b04421f3-1f39-47eb-84db-e5ef5b4bbd4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

