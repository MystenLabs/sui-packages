module 0x2b00a9e381000e9c53a66f4a8aa0196388373d44ca138ab9f3deeeb5ad34df04::tai {
    struct TAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAI>(arg0, 6, b"TAI", b"First Tailmon on Sui", b"The time for Tailmon is now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_11_90ddd5d9fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

