module 0x9ef8030b9a1709736722c6ec3f741edccea10ddf2442c46827ff5ba652c3bcb5::panini {
    struct PANINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANINI>(arg0, 6, b"PANINI", b"Hot Dog Panini", b"I'm not a hot dog, I'm a Panini!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_13_at_2_38_07a_PM_bb95c3b97d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

