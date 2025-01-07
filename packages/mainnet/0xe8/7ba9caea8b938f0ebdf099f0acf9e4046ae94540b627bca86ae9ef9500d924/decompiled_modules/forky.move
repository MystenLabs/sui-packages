module 0xe87ba9caea8b938f0ebdf099f0acf9e4046ae94540b627bca86ae9ef9500d924::forky {
    struct FORKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORKY>(arg0, 6, b"FORKY", b"Forky on sui", b"Meet $FORKY. The fork of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x3e2242cb2fc1465822a0bb81ca2fe1f633a45757_58ea13987a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

