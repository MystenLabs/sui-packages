module 0x35aff944d88ee96ca1afd8275efea54a695da9fa4b6bf32996c6338a5de8e3::mrt {
    struct MRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRT>(arg0, 6, b"MRT01", b"MRT token", b"this is my token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1745384206006669312/fi1rMGEb_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRT>>(v1);
        0x2::coin::mint_and_transfer<MRT>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun reounceownership(arg0: 0x2::coin::TreasuryCap<MRT>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRT>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

