module 0xe54ff1bfb8560be45e74db4153c0b7ca0c4c495e16790c557a2442431ac43182::stc {
    struct STC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STC>(arg0, 8, b"STC", b"Shitcoin", b"The ultimate crypto content hub ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JGKuPNp.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STC>(&mut v2, 32100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STC>>(v1);
    }

    // decompiled from Move bytecode v6
}

