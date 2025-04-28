module 0xf11ac0fb9cfeeee7dc2521b5d497374812cd8341fba3f807dca3b33be0639cf3::rape {
    struct RAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPE>(arg0, 9, b"RAPE", b"Red Ape", b"Red Ape on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2145ea889b3d35b3f83ccac0a9e3691bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

