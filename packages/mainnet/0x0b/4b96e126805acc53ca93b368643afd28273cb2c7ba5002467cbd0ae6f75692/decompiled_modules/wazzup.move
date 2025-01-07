module 0xb4b96e126805acc53ca93b368643afd28273cb2c7ba5002467cbd0ae6f75692::wazzup {
    struct WAZZUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAZZUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAZZUP>(arg0, 6, b"WAZZUP", b"WAZZUP SUI", b"WAAAAAAAAAAAAAAAAAAZZZZZZZZZZZZZZZUUUUUUUUUUUUUUUUPPPPPPPPPPPPPPP SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_f90f62fecc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAZZUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAZZUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

