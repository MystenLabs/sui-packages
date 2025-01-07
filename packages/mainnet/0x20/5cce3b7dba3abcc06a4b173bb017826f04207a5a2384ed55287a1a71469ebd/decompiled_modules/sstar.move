module 0x205cce3b7dba3abcc06a4b173bb017826f04207a5a2384ed55287a1a71469ebd::sstar {
    struct SSTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTAR>(arg0, 6, b"SSTAR", b"SUTSTART", x"4f757220706f6f7220535441524649534820697320747279696e6720746f20636f6f6b20736f6d652024535441524620666f72206869732066616d696c792e200a0a4865206e6565647320796f75722068656c702c206c657427732068656c702068696d20746f20636f6f6b206f6e2023535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038988_10f999f27d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

