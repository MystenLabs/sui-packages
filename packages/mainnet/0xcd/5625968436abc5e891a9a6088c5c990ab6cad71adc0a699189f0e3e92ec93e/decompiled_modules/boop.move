module 0xcd5625968436abc5e891a9a6088c5c990ab6cad71adc0a699189f0e3e92ec93e::boop {
    struct BOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOP>(arg0, 6, b"Boop", b"Boop On Sui", b"Boop Token ($BOOP) is a community-driven cryptocurrency inspired by the love and loyalty of dogs. It aims to unite dog lovers and crypto enthusiasts in a fun, engaging ecosystem that supports pet welfare initiatives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_20_at_2_24_46a_pm_158e6a329c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

