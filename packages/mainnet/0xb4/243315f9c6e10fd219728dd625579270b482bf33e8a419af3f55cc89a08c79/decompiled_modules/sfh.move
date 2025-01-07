module 0xb4243315f9c6e10fd219728dd625579270b482bf33e8a419af3f55cc89a08c79::sfh {
    struct SFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFH>(arg0, 9, b"SFH", b"SFH", b"FJHFJSKEYNHF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFH>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

