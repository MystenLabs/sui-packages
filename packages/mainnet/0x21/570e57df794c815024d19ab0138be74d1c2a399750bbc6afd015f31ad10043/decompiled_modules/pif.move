module 0x21570e57df794c815024d19ab0138be74d1c2a399750bbc6afd015f31ad10043::pif {
    struct PIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIF>(arg0, 6, b"PIF", b"Peanut wif hat", b"Peanut wif hat :')", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pwh_0131b23fe6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

