module 0x5414d7a6b0eb00e13b6c99fe8958dd86d0f0e95c263f553fba6a190ebd99fca3::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 6, b"Tom", b"TraderTom", x"54726164657220546f6de2809973206d656d652068756e74696e6720746563686e6971756520697320612077696c642072696465206f6620686967682d737065656420616e616c797369732c20637265617469766520626c656e64696e672c20616e6420737472617465676963206465706c6f796d656e742c20616c6c207772617070656420757020696e2068697320717569726b7920616e6420656e6572676574696320706572736f6e612e2048652773206e6f74206a7573742068756e74696e67206d656d65733b2068652773206372656174696e672061206d656d65206c656761637921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732397832517.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

