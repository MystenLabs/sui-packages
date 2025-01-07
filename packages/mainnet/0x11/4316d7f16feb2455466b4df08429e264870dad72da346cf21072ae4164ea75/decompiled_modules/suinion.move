module 0x114316d7f16feb2455466b4df08429e264870dad72da346cf21072ae4164ea75::suinion {
    struct SUINION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINION>(arg0, 9, b"SUINION", b"SUINION", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINION>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINION>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINION>>(v1);
    }

    // decompiled from Move bytecode v6
}

