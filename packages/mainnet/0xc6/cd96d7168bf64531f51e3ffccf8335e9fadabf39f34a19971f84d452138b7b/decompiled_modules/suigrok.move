module 0xc6cd96d7168bf64531f51e3ffccf8335e9fadabf39f34a19971f84d452138b7b::suigrok {
    struct SUIGROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGROK>(arg0, 6, b"SUIGROK", b"SuigrokOnSui", b"SuiGrok is inspired by a once irreparable robot that was revived through advanced AI and medical expertise, combining cutting-edge machine parts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000124_15e4cfabfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

