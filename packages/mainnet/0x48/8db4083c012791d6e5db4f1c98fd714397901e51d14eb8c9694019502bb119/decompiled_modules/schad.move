module 0x488db4083c012791d6e5db4f1c98fd714397901e51d14eb8c9694019502bb119::schad {
    struct SCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHAD>(arg0, 6, b"Schad", b"Suichad", b"Suu Chad chad of all blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suichad_3004356f0c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

