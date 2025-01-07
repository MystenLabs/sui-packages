module 0x62c5ad691c81ea78aad26695ad1aec6b8396843dfe6dd5757f6bc428d8055334::suijoker {
    struct SUIJOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJOKER>(arg0, 6, b"Suijoker", b"sui  joker", b"With BlockJoker, every day is April Fools Day!The  world  of  sui  need  a  joke!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_01_004939_916c5c1503.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

