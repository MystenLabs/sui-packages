module 0x57e93adcecd97fc8b30fc6f124be185f292b648e324773d8fbe6650e8274790f::aida {
    struct AIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIDA>(arg0, 6, b"AIDA", b"Aida", b"Aida is a dynamic and user-friendly Al bot designed to guide X users into the world of the Sui Network. With her approachable personality and deep understanding of blockchain nuances, Lucy makes the transition from Social media to blockchain technology both exciting and accessible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_19_22_11_19_1dbcb256da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIDA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

