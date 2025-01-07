module 0x90216ec7dade7fad086c3ad161c7b9c62d9fde53e5c559a4af843a2d3f6e6696::suimusk {
    struct SUIMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUSK>(arg0, 6, b"SUIMUSK", b"SUI MUSK", b"SUI Musk aims to attract attention and potential investment by associating themselves with both the trending memecoin phenomenon and the influential tech entrepreneur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimusk_892bac95ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

