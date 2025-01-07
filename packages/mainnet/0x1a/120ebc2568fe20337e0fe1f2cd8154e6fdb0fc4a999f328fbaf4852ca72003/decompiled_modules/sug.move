module 0x1a120ebc2568fe20337e0fe1f2cd8154e6fdb0fc4a999f328fbaf4852ca72003::sug {
    struct SUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUG>(arg0, 6, b"SUG", b"Seal Pug", b"Is that a seal? Is that a pug? Wait a second... that's a sug!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUGG_c1f50ee2a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

