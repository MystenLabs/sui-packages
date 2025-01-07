module 0xa1fe3925579e0cb70a3f32e95c22bd4be199479bc1aa1ab5d289de4398e3dd59::ita {
    struct ITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITA>(arg0, 6, b"ITA", b"ITA, ITO's WIFE", b"$ITA is ITO's wife and she is a lady look how she stares at you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/17_3b99472e2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

