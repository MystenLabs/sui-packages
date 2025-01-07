module 0x6ed1df0f8a968098591b5d59d315133a15fc448f52d45382023d682b8eefea56::iwy {
    struct IWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWY>(arg0, 6, b"IWY", b"I Want You", b"I WANT YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VOTE_5d7983b188.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

