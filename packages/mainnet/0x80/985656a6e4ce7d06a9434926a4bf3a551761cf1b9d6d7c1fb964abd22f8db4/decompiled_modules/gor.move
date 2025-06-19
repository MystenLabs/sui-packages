module 0x80985656a6e4ce7d06a9434926a4bf3a551761cf1b9d6d7c1fb964abd22f8db4::gor {
    struct GOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOR>(arg0, 8, b"GOR", b"Gorbagana", b"Gorbagan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/500b9977-5b6f-455d-b5e8-ea1a1f370f22.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

