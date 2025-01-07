module 0x33e5feb89edad8029299afd7753999aeceb09e1e9bd50cf6d42baf738432dc41::syg {
    struct SYG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYG>(arg0, 6, b"SYG", b"Spon", b"abc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731595215742.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

