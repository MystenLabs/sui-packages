module 0x301c08973357a8b55d0103cbeffc34a8c7d26b457a5819442e89ec41e8aea517::mun2 {
    struct MUN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN2>(arg0, 9, b"MUN2", b"Mun 02", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/f4a5955eb3254daf5f8963bc1ddb5d59blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUN2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

