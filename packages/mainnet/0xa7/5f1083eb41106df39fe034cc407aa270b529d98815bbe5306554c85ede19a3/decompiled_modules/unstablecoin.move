module 0xa75f1083eb41106df39fe034cc407aa270b529d98815bbe5306554c85ede19a3::unstablecoin {
    struct UNSTABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNSTABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNSTABLECOIN>(arg0, 6, b"Unstablecoin", b"un stablecoin", x"61206e61727261746976652077726974657320697473656c6620210a0a626974636f696e202f20616c74636f696e20207e20737461626c65636f696e202f20756e737461626c65636f696e2e0a0a756e737461626c65636f696e20697320726964696e672074686520737461626c65636f696e206e61727261746976652c20696d6167696e6520686f7720626967207468697320776f756c6420626521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibkaz3j4hewovjz7af4rseqo2f7mippdgui6kbshixjcruoweedzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNSTABLECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNSTABLECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

