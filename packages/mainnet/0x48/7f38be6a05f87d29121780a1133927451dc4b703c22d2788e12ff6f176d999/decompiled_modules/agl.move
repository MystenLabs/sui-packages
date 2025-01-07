module 0x487f38be6a05f87d29121780a1133927451dc4b703c22d2788e12ff6f176d999::agl {
    struct AGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGL>(arg0, 6, b"AGL", b"Ani Girls Love", b"AGL AKA Ani Girls Love IS NEW IN COME FOR ALL ANI GIRL LOVERS OUT THERE MORE TO COME THIS JUST THE BEGINNING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5b3803d7_d3c5_442b_8428_9fc826fb4f49_c66f323e5a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

