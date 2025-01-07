module 0xdddfc8020ae1aca47bf5cd7953931211f5fc811cb409d6014b002243e579ae1::otto {
    struct OTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTO>(arg0, 6, b"OTTO", b"Otto The Otter", b"Meet Otto, Pnuts best friend from the sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049234_b5b1ee26bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

