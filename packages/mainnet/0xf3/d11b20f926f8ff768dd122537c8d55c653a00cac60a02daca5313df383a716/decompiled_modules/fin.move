module 0xf3d11b20f926f8ff768dd122537c8d55c653a00cac60a02daca5313df383a716::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"FIN", b"Fin", b"Ride the waves with FIN, the Sui Mako Shark that's making a splash!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fin_1801dfdf4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

