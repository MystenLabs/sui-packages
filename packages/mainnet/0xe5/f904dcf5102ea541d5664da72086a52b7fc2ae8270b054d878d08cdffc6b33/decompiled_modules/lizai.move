module 0xe5f904dcf5102ea541d5664da72086a52b7fc2ae8270b054d878d08cdffc6b33::lizai {
    struct LIZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIZAI>(arg0, 6, b"LIZAI", b"SUI LIZA AI", b"Star dreaming and creat with Liza AI..Welcome to A new generation with LIZA AI. Creat a Picture for collect AI...Very smart and simple for creat with LIZA AI...Intelligent Assistant.....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_1734980468891345_7bb5d0b428.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIZAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

