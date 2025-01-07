module 0x36460d78443124dfec1055ea2705732e90e061a75bc7fbb1ff41a6913a540b43::ford {
    struct FORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORD>(arg0, 6, b"FORD", b"FAIRLY USED FORD CAR", b"CAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/download_a04e966191.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

