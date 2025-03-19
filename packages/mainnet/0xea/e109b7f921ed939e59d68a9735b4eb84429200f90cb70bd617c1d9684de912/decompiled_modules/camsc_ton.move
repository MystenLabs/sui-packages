module 0xeae109b7f921ed939e59d68a9735b4eb84429200f90cb70bd617c1d9684de912::camsc_ton {
    struct CAMSC_TON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMSC_TON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742353356177.png"));
        let (v1, v2) = 0x2::coin::create_currency<CAMSC_TON>(arg0, 6, b"CAMSC", b"CAMSC_TON", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMSC_TON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAMSC_TON>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<CAMSC_TON>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAMSC_TON>>(arg0);
    }

    // decompiled from Move bytecode v6
}

