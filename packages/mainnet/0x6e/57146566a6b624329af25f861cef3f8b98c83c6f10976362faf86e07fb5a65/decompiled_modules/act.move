module 0x6e57146566a6b624329af25f861cef3f8b98c83c6f10976362faf86e07fb5a65::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 6, b"ACT", b"Act I : The AI Prophecy", b"Act I is one of the few projects exploring how to engage with AI beyond a cold and damp 1-on-1 user/assistant paradigm, but as a network of equals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ae_O5_363_400x400_bf7838f06d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

