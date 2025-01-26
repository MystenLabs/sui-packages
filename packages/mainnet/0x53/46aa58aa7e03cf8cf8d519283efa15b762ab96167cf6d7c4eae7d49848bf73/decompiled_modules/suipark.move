module 0x5346aa58aa7e03cf8cf8d519283efa15b762ab96167cf6d7c4eae7d49848bf73::suipark {
    struct SUIPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPARK>(arg0, 6, b"SUIPARK", b"Sui South Park", b"I'm goin' down to South Park gonna have myself a time! SOUTH PARK ON SUI CHAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiparkprofff_95cdfecbc0.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

