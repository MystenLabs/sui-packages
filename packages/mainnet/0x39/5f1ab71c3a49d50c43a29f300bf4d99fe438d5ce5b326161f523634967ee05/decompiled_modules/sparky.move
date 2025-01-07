module 0x395f1ab71c3a49d50c43a29f300bf4d99fe438d5ce5b326161f523634967ee05::sparky {
    struct SPARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARKY>(arg0, 6, b"SPARKY", b"Sparky On Sui", b"SPARKY TOKEN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sparky_762a501de9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

