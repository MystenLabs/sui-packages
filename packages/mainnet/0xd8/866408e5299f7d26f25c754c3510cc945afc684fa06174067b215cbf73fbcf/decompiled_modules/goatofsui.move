module 0xd8866408e5299f7d26f25c754c3510cc945afc684fa06174067b215cbf73fbcf::goatofsui {
    struct GOATOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATOFSUI>(arg0, 6, b"GOATOFSUI", b"GOAT", b"NFT GOAT OF SUI IS POWER FULL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732110664833.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOATOFSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATOFSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

