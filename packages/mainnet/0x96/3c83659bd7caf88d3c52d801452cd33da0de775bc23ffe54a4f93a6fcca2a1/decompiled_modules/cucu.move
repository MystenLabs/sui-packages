module 0x963c83659bd7caf88d3c52d801452cd33da0de775bc23ffe54a4f93a6fcca2a1::cucu {
    struct CUCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCU>(arg0, 6, b"CUCU", b"SUI Cucumber", b"No socials.No bs.Just hanging out, waiting for the next big wave on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2452_43f4aa5de7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUCU>>(v1);
    }

    // decompiled from Move bytecode v6
}

