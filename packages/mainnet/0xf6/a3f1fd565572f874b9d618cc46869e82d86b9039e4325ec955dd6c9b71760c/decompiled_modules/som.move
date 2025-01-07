module 0xf6a3f1fd565572f874b9d618cc46869e82d86b9039e4325ec955dd6c9b71760c::som {
    struct SOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOM>(arg0, 6, b"SOM", b"Sui of Meme", b"No hesitate ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bz_Q_Tl_Zx_B_400x400_ae97567705.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

