module 0xfb5ccfa2675458c75909f5e9d68cf1d3641010a2ecff667a01426a26ecf78849::venom {
    struct VENOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENOM>(arg0, 6, b"VENOM", b"venumusk", x"56656e6f6d2063616d6520746f20456172746820746f2066696e642061206d616e2077686f20636f756c64207472616e73706f7274206869732066656c6c6f77207472696265736d656e2066726f6d207468656972206479696e6720686f6d6520706c616e65742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1735918418125_01398b5cff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

