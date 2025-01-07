module 0xb937057db11774aa86f422004801edaa29db5b712fb8114dff7072d08095c39d::suison {
    struct SUISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISON>(arg0, 9, b"suison", b"suison", b"suison of suiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISON>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISON>>(v1);
    }

    // decompiled from Move bytecode v6
}

