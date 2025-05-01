module 0xe32107e164bcc1153ba60931ac2bc9f8126624456cda26f273daeb8ffc78885f::bananza {
    struct BANANZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANZA>(arg0, 6, b"Bananza", b"BANANZA", x"57656c636f6d6520746f2042616e616e7a612c20776865726520746865206d61726b65747320736c69702c20736c6964652c20616e6420676f206162736f6c7574656c792062616e616e61732120200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bananza_logo_4e7c52638e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

