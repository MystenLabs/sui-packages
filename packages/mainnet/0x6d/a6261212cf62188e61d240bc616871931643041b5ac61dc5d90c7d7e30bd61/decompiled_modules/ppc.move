module 0x6da6261212cf62188e61d240bc616871931643041b5ac61dc5d90c7d7e30bd61::ppc {
    struct PPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPC>(arg0, 6, b"PPC", b"Pudi Panda Coin", b"Pudi Panda Coin is for those wo believe wealth comes to those who chill,. Whatever, win anyway - because sometimes the void gives back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026475_7cb20e5a7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

