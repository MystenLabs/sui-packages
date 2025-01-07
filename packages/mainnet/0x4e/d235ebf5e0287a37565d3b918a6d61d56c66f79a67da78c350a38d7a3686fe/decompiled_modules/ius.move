module 0x4ed235ebf5e0287a37565d3b918a6d61d56c66f79a67da78c350a38d7a3686fe::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 9, b"iuS", b"iuS", b"Sui, bot iuS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.ius.edu.ba/sites/default/files/gbb-uploads/ius-logo-buyuk_0.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IUS>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

