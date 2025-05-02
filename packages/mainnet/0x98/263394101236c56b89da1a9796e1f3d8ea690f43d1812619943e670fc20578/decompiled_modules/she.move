module 0x98263394101236c56b89da1a9796e1f3d8ea690f43d1812619943e670fc20578::she {
    struct SHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHE>(arg0, 9, b"she", b"she", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

