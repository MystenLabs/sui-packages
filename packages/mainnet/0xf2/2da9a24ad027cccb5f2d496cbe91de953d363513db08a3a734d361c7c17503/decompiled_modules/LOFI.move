module 0xf22da9a24ad027cccb5f2d496cbe91de953d363513db08a3a734d361c7c17503::LOFI {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOFI>>(v0);
    }

    public fun mint(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<LOFI>, 0x2::coin::CoinMetadata<LOFI>) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 9, b"LOFI", b"LOFI", b"Lofi is everyone's favorite Yeti on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fM8QZXh/LOFI-PFP.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOFI>(&mut v2, 1000000000000000000, @0x6fe47d26b342d668fd11d0d09802c66e1ff2e0538308fecbc37ae842336028ab, arg1);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

