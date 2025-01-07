module 0x6600ff2392573b5318adc9158d9fa33117324f9a1dcc174bae3b29dfa9be0fc::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANK>(arg0, 6, b"DANK", b"Dank", b"Dank Dank Dank Dank Dank on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_05_10_58_dbcbddeafb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

