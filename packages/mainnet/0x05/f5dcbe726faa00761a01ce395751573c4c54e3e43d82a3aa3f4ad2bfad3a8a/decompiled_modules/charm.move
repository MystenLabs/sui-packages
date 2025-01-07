module 0x5f5dcbe726faa00761a01ce395751573c4c54e3e43d82a3aa3f4ad2bfad3a8a::charm {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARM>(arg0, 6, b"Charm", b"CHARMANDERSUI", x"436861726d537569206973206120666972652d636861726765642063727970746f63757272656e6379206f6e207468652053554920626c6f636b636861696e2c20737061726b696e6720696e6e6f766174696f6e20616e6420656c65637472696679696e67207468652063727970746f20776f726c64210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196881_98af8781d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

