module 0x887f0c00b13320e7692b18d6e71cfb4942df78608f4c29334833dd042754163::bandw {
    struct BANDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDW>(arg0, 10, b"BandW", b"StoveToP", b"Brown rice and Walnuts w/ ~ the (stuffing mix)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1AStLLtxYaulBl3CFTPxfraVRJ9j-QTpJ/view?usp=drivesdk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANDW>(&mut v2, 120000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDW>>(v1);
    }

    // decompiled from Move bytecode v6
}

