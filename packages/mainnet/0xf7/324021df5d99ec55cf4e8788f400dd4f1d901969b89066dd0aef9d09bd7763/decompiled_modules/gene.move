module 0xf7324021df5d99ec55cf4e8788f400dd4f1d901969b89066dd0aef9d09bd7763::gene {
    struct GENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENE>(arg0, 6, b"GENE", b"Gene AI", b"GeneAl let users access to BIO's network of scientific communities and IP, enabling broad exposure to the DeSci economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735808824833.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

