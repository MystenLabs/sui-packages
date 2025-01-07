module 0xcb6b2d2e456eeb6d8def5d8d73cdc55f67216a7fa65dbd4a5bf8b594a030b110::suiamond {
    struct SUIAMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMOND>(arg0, 6, b"Suiamond", b"Diamond on Sui", b"diamond of sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfds_cf24f81661.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAMOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

