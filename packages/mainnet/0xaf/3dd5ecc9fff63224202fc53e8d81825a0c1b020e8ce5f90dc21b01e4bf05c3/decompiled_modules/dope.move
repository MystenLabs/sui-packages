module 0xaf3dd5ecc9fff63224202fc53e8d81825a0c1b020e8ce5f90dc21b01e4bf05c3::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 6, b"DOPE", b"Dope", x"5468657265e2809973206e6f20686f706520696e20444f50452120546865204e6f20486f706520636f6d6d756e697479207061796d656e742077616c6c20666f722067657474696e6720646f70656865616473206f7574206f66207468652067757474657221200a20202020444f504520203d20204465617468206f7220507269736f6e204576656e7475616c6c79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751154718604.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

