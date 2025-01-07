module 0x1bb7de58e688eb5e6ffcff6745baa982fd0fed4339706752255076cf6842cbd6::sfs {
    struct SFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFS>(arg0, 6, b"SFS", b"Sui Frog Slang", b"Hatchling PEPE, let's help it grow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_09_25_37_2828d2132a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

