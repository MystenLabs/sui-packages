module 0xd16b3b677435b6e6b23cc255abec31470c7f730dcfb29682e276441f1f6839b2::maniext {
    struct MANIEXT has drop {
        dummy_field: bool,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<MANIEXT>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &AdminCap, arg1: &mut Treasury, arg2: 0x2::coin::Coin<MANIEXT>) {
        0x2::coin::burn<MANIEXT>(&mut arg1.cap, arg2);
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MANIEXT>>(0x2::coin::mint<MANIEXT>(&mut arg1.cap, arg2, arg4), arg3);
    }

    fun init(arg0: MANIEXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANIEXT>(arg0, 9, b"MANIEXT", b"Maniext", x"4d6f6e6b69746f20284d414e494558542920e28094206120746f6b656e2064657369676e656420666f7220696e6e6f766174696f6e2c2067726f7774682c20616e64206c6f6e672d7465726d20636f6d6d756e6974792076616c75652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANIEXT>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MANIEXT>>(0x2::coin::mint<MANIEXT>(&mut v2, 1000000000000000000, arg1), v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::public_transfer<AdminCap>(v4, v3);
        0x2::transfer::public_transfer<Treasury>(v5, v3);
    }

    // decompiled from Move bytecode v6
}

