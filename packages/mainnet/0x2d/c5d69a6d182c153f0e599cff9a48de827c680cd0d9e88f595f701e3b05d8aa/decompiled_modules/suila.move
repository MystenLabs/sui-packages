module 0x2dc5d69a6d182c153f0e599cff9a48de827c680cd0d9e88f595f701e3b05d8aa::suila {
    struct SUILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILA>(arg0, 6, b"SUILA", b"The Animes On Sui", b"Sui for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umaru_doma_star_eyes_02c31dac37.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILA>>(v1);
    }

    // decompiled from Move bytecode v6
}

