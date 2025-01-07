module 0x1f8ded8011c94c839ad665748e4055104b829c4bf188101fff1a51d4e1085048::blasty {
    struct BLASTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTY>(arg0, 6, b"BLASTY", b"Blasty Dog", b"Blasty Dog available on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/15564e_bdc679d4509a46aca47d7635f1f21164_mv2_37fd6cecf0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

