module 0x39c4da4fd252d6d56b428bc7a91d2ac8dfed9a220ee715faca2aec032c22f4f0::ugly {
    struct UGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGLY>(arg0, 9, b"UGLY", b"ugly", b"ugly thing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4200492b-6f78-4498-845f-1c7f7c528d13.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UGLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

