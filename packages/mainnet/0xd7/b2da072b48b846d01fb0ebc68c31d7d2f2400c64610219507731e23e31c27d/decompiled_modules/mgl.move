module 0xd7b2da072b48b846d01fb0ebc68c31d7d2f2400c64610219507731e23e31c27d::mgl {
    struct MGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGL>(arg0, 5, b"MGL", b"Megalodon", b"Megalodon, deep sea monster...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/R01N3rd/megalodon.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MGL>(&mut v2, 4700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

