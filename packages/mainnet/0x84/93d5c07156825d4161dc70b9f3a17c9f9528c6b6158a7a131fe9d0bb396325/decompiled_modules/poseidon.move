module 0x8493d5c07156825d4161dc70b9f3a17c9f9528c6b6158a7a131fe9d0bb396325::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 6, b"POSEIDON", b"Poseidon AI", x"57652075736520414920746f2063726561746520506f736569646f6e2022476f64206f66207468652053656122200a4d616b652072756c657320666f72202453554920776174657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734551544877.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

