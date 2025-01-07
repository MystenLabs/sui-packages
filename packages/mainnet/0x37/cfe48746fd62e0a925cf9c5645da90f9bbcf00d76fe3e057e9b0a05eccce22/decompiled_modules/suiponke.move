module 0x37cfe48746fd62e0a925cf9c5645da90f9bbcf00d76fe3e057e9b0a05eccce22::suiponke {
    struct SUIPONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPONKE>(arg0, 9, b"SuiPonke", b"Sui Ponke", b"The Golden G of SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafkreidzgrlu4sbz36yl42idg6txzmw6gwv45wfaj23hxe7hpbqgxb2q6m"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPONKE>>(v1);
        0x2::coin::mint_and_transfer<SUIPONKE>(&mut v2, 1000000000000000000, @0x943f9b48e3dd60ee55e41337c8554faa5cb09a486799e08fcf4c79112216b39f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIPONKE>>(v2);
    }

    // decompiled from Move bytecode v6
}

