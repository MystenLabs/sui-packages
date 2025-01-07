module 0x37c07b2a1f9d247bde2b5e4f5e51ad6b410ed3072029fbec4ede4760228b08f8::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"Fin", b"Shark Fin", b"A sharp fin slicing through the Sui waters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shark_Fin_07689f9745.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

