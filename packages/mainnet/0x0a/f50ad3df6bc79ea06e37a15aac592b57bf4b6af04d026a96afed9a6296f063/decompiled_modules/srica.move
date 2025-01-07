module 0xaf50ad3df6bc79ea06e37a15aac592b57bf4b6af04d026a96afed9a6296f063::srica {
    struct SRICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRICA>(arg0, 1, b"SRICA", b"PirateRica on Sui", b"LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRICA>(&mut v2, 3253252465242540, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRICA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

