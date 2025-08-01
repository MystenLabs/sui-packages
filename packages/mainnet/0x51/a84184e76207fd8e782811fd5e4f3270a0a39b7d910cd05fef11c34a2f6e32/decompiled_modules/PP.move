module 0x51a84184e76207fd8e782811fd5e4f3270a0a39b7d910cd05fef11c34a2f6e32::PP {
    struct PP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP>(arg0, 6, b"Powell Pittance ", b"Pp", b"Grow your PP - Powell Pittance. He's not lowering rates but we can print magic Internet money ourselves brrrr. Grow your PP.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/bfe3ad7d-f983-462c-92e3-8ecba0fa7f4b")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP>>(v0, @0x33102a24fc3f8035cd898d31b0a16a41f1e687674dc94dff4842d83deca4e58b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PP>>(v1);
    }

    // decompiled from Move bytecode v6
}

