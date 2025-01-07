module 0x19893070cdb82e6ac5000e260b32eff3996739ab5267c066bae2e2738ae73431::givesui {
    struct GIVESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIVESUI>(arg0, 6, b"GIVESUI", b"GIVE ME SUI", b"GIVE ME SUI 0xc7aab164786f4621be2cbf5e2b0b40342f55aec66c4ba14c5c84305e62659193", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5474401058655691256_810119e87e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIVESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIVESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

