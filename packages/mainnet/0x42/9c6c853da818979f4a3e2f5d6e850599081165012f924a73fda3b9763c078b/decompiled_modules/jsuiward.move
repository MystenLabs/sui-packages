module 0x429c6c853da818979f4a3e2f5d6e850599081165012f924a73fda3b9763c078b::jsuiward {
    struct JSUIWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSUIWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSUIWARD>(arg0, 6, b"JSUIWARD", b"Jeeted suidward", b"Help!!!! I jeeted all my money away. You rich chads can help", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5824_ddff4ffe81.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSUIWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSUIWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

