module 0x391e5d62abb5f6baa481de907ab1901d86553c376dd357ddd6e1b3bd7b4e57fc::sbtn {
    struct SBTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTN>(arg0, 6, b"SBTN", b"SBTN (Sabotten)", b"A cute, lazy cactus that rewards you for taking it easy and relaxing. Inspired by the Japanese word 'Saboten' meaning cactus, and 'Sabotten' meaning to be lazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SBTN_Coin_ca83d4d4bc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

