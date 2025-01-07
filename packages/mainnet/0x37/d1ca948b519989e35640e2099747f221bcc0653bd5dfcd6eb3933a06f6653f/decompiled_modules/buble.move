module 0x37d1ca948b519989e35640e2099747f221bcc0653bd5dfcd6eb3933a06f6653f::buble {
    struct BUBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBLE>(arg0, 9, b"BUBLE", b"Buble Blue", b"BUBLE CUTE 10B MC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBLE>(&mut v2, 255000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

