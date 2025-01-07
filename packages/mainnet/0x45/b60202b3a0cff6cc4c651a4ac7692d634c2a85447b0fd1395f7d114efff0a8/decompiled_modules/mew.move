module 0x45b60202b3a0cff6cc4c651a4ac7692d634c2a85447b0fd1395f7d114efff0a8::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"Mew Woof", b"MEW WOOF WOOF MEW. $MEW  is the pack, now on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S30m1_RHD_400x400_de37f536eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

