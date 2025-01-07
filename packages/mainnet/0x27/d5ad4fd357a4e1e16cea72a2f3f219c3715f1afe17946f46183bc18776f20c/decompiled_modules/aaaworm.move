module 0x27d5ad4fd357a4e1e16cea72a2f3f219c3715f1afe17946f46183bc18776f20c::aaaworm {
    struct AAAWORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAWORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAWORM>(arg0, 6, b"aaaWORM", b"aaaWorm", b"following the aaa meta $aaaWORM it's bringing the deserved importance to a just cause for the worms that are used as fishing bait in this cruel ocean, where only the strongest survive. Leave the worms in peace, #FREEWORMS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_4b3541756f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAWORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAWORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

