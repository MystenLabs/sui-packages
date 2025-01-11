module 0xccd0febf11252303b6a17520dc0bf0fcbd8c7d3d85f682a0366fd02fa2d23a77::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: 0x2::coin::Coin<PEPE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PEPE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE-THINK2", b"PEPE2", b"PEPE2 THINK MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/raidenx-no-cors/token-icons/pepe-think.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, @0xad4c1dd43fc5ec5fafd29314845961792ba4827c4e076d915185330509cbfe06);
    }

    // decompiled from Move bytecode v6
}

