module 0x433593355d30d45c3e40fd39fdd5a141773cda9034aac03bf43407f9b80a913b::toreto {
    struct TORETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORETO>(arg0, 6, b"Toreto", b"Dominic Toreto", b"Dominic Toreto on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953383011.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORETO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORETO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

