module 0x5f339a27cc28097f0fc2675d30f8687c4b682b84bc5841e68e713e3de7d6882f::thanks {
    struct THANKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THANKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THANKS>(arg0, 6, b"THANKS", b"DANKE", b"GRACIAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TELEGRAM_BETEU_059fb89864.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THANKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THANKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

