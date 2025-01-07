module 0x18d8fdee055907c8108bab4455be0b21b476ee2791e9534a2444349a79cf47d0::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 6, b"SOCKS", b"socks", b"Socks, the White House cat during the Clinton administration who waged war on Buddy the pup, has died. He was around 18.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0013729e42d20b0c864b23_f173f0f84b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

