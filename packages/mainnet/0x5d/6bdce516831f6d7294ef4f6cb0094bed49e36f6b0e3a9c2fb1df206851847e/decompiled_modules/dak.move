module 0x5d6bdce516831f6d7294ef4f6cb0094bed49e36f6b0e3a9c2fb1df206851847e::dak {
    struct DAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAK>(arg0, 6, b"DAK", b"DAK on SUI", b"EVERYTHING IS GOING ACCORDING TO PLAN, WE ARE GONNA TO TAKE OFF!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972189820.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

