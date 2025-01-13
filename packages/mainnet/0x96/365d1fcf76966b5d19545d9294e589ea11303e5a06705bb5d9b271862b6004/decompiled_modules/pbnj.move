module 0x96365d1fcf76966b5d19545d9294e589ea11303e5a06705bb5d9b271862b6004::pbnj {
    struct PBNJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBNJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBNJ>(arg0, 6, b"PBnJ", b"Sui Sammich", b"Where perfect collaboration of simplicity and nostalgia is achieved.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736735238730.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBNJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBNJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

