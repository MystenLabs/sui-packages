module 0xa8a69f2340fe1c57935ec169f2bfccdc1dc9bd107e9835437bb8c8fbac80f3cd::smika {
    struct SMIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMIKA>(arg0, 6, b"SMIKA", b"SMIKASUI", b"Don't take life too seriously, because you'll never get out alive. Let's have some fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Smika_329b801b6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

