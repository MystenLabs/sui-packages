module 0xb514e637c8d1fea18913f6ab3a79fb7b43a430aa9c62b3108e19e35a4cef5f4c::srex {
    struct SREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SREX>(arg0, 6, b"SREX", b"Sui Rex", b"SUI REX is feisty, blue, and kinda cute as well. $SREX, the king on SUI, ready to reclaim the throne. Join us in reviving fossils and proving who the apex predator on SUI truly is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trex_Logo_asli_433793fab5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

