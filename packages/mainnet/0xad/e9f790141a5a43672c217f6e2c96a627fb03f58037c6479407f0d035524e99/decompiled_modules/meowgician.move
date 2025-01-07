module 0xade9f790141a5a43672c217f6e2c96a627fb03f58037c6479407f0d035524e99::meowgician {
    struct MEOWGICIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWGICIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWGICIAN>(arg0, 6, b"MEOWGICIAN", b"Meowgician Cat", b"Hoomans im here to create chaos, join my academy and combine our magic so we ca TAKE OVER THE WORLD!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_a2a34239c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWGICIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWGICIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

