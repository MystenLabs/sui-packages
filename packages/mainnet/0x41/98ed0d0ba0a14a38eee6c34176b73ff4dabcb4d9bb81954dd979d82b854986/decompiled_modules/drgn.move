module 0x4198ed0d0ba0a14a38eee6c34176b73ff4dabcb4d9bb81954dd979d82b854986::drgn {
    struct DRGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRGN>(arg0, 6, b"DRGN", b"DRAGONSUI", b"Im the Dragon of Sui chain, RAWRRRRRRRRR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dragon_8fb635a066.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

