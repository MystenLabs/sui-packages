module 0xf3a9605324208dca5af19f865a360bc8758abf87562c823f941d331efd6999ce::gobi {
    struct GOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBI>(arg0, 6, b"GOBI", b"GOBI on SUI", b"Mischievous lil $GOBI playing pranks around", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_YZ_Qft_400x400_0252422545.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

