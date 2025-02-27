module 0x14f103dd05df895c67e128f9db93cf67501cb59b53b6260edb42e0037ad859e5::rsui {
    struct RSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSUI>(arg0, 6, b"RSUI", b"RSUI", b"RSUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/nfttokenasa/image/upload/v1740644506/qavcs7etnm0ko0q4z3r6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RSUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

