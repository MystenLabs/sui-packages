module 0xf9dcf7c59af85e995756e9c328c1ff4219e095587ea2c9387f2bf7c0d629fe09::suiter {
    struct SUITER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITER>(arg0, 6, b"SUITER", b"Sui Twitter", b"$SUITER is a decentralized social media platform, built on the Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitter_293239c1d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITER>>(v1);
    }

    // decompiled from Move bytecode v6
}

