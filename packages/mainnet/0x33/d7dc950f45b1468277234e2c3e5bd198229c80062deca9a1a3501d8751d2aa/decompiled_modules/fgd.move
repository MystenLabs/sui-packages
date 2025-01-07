module 0x33d7dc950f45b1468277234e2c3e5bd198229c80062deca9a1a3501d8751d2aa::fgd {
    struct FGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGD>(arg0, 6, b"FGD", b"FGG", b"dddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/506802698_1107183dae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

