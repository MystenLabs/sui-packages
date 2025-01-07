module 0x42e490479a5b5bb05825252dbe34e2c520a7b38960485745fe4c0c9dff37266::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 9, b"EGG", b"egg", b"$EGG is the only currency older than Gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FLOGO_3_f5a585c490.png&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EGG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

