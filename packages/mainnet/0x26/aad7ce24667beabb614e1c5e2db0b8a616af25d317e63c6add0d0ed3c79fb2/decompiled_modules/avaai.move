module 0x26aad7ce24667beabb614e1c5e2db0b8a616af25d317e63c6add0d0ed3c79fb2::avaai {
    struct AVAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAAI>(arg0, 9, b"AvaAI", b"ava ai", b"AI Intern at Holoworld AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c05e47c822de79db3e908257adfaf439blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVAAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

