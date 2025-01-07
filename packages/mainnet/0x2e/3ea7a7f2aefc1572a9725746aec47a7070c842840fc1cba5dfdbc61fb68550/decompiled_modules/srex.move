module 0x2e3ea7a7f2aefc1572a9725746aec47a7070c842840fc1cba5dfdbc61fb68550::srex {
    struct SREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SREX>(arg0, 6, b"SREX", b"Suirex", b"SUI REX is feisty, blue, and kinda cute as well. $SREX, the king on SUI, ready to reclaim the throne. Join us in reviving fossils and proving who the apex predator on SUI truly is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trex_Logo_asli_b2a44a1a07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

