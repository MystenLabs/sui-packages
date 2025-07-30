module 0x58d2c308181dc6aacce206158a41d2d10b9fecbccdd12f6944d62d54faf3ebdc::HOWL {
    struct HOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOWL>(arg0, 6, b"HowlCoin", b"HOWL", b"A moon-bound meme coin for the wild and untamed! HowlCoin celebrates the primal spirit of werewolves, with a community that thrives under the full moon. Whether you're a lone wolf or part of the pack, HOWL is your ticket to the next lunar rally. Beware of silver hands!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/G0MmHpEHsioEE1IZ5pRKqbBNR9x9dnLooff1VNn2ePU3SfXUB/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOWL>>(v0, @0xbdebc33436425c9a7ca66a3b35925621c8885d16b3c741b9ca39527620462511);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

