module 0x9a4137f75869e7f08398a8884e1ed3c608dc23cebbdd17964cee512fe413bd::sig {
    struct SIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIG>(arg0, 6, b"SIG", b"SIG ON SUI", b"SIG can be whoever he wants: the bald, the testosterone hairy, but SIG always", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suispiciously_f5f25c1d42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

