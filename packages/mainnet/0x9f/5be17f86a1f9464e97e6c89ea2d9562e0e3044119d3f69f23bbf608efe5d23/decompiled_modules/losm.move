module 0x9f5be17f86a1f9464e97e6c89ea2d9562e0e3044119d3f69f23bbf608efe5d23::losm {
    struct LOSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOSM>(arg0, 6, b"LOSM", b"Laugh-o-SuiMatic", b"Laugh-o-Matic is a groundbreaking token that bridges artificial intelligence and entertainment within the digital economy. Designed to power the Laugh-o-Matic AI ecosystem, this token enables users to interact with the world's most advanced comedy bo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736166231023.31")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOSM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOSM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

