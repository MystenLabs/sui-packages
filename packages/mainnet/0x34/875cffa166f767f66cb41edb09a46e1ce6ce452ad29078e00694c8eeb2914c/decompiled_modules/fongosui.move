module 0x34875cffa166f767f66cb41edb09a46e1ce6ce452ad29078e00694c8eeb2914c::fongosui {
    struct FONGOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONGOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FONGOSUI>(arg0, 9, b"FONGOSUI", b"Fongo On Sui", b"FONGOSUI on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FONGOSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONGOSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FONGOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

