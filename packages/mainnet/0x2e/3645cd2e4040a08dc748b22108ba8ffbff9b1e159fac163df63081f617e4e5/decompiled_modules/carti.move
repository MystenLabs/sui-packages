module 0x2e3645cd2e4040a08dc748b22108ba8ffbff9b1e159fac163df63081f617e4e5::carti {
    struct CARTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTI>(arg0, 9, b"CARTI", b"CARTI", b"CARTI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CARTI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

