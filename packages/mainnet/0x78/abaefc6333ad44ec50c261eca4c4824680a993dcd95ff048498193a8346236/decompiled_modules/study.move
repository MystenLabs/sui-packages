module 0x78abaefc6333ad44ec50c261eca4c4824680a993dcd95ff048498193a8346236::study {
    struct STUDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUDY>(arg0, 6, b"Study", b"Study Sui", b"Sui posted study sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12321311_01_d7f7d1159e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

