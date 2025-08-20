module 0xe7529f2b03359774887ec81f751559b056f3e4474915c7fdcd0e6f1869840fec::chkdo {
    struct CHKDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHKDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHKDO>(arg0, 9, b"CHKDO", b"SuiChonkoDile", b"chil hcil asdhhasdhadsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHKDO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHKDO>>(v2, @0x1dda21a39efbd871b446d529d153d166786459a8b5b93d7d3aad0f89a1b03c3b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHKDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

