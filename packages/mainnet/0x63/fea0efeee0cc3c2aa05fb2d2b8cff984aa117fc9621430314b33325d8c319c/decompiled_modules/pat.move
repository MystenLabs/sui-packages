module 0x63fea0efeee0cc3c2aa05fb2d2b8cff984aa117fc9621430314b33325d8c319c::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAT>(arg0, 6, b"PAT", b"Pat, Pepe's cat", b"Meet PAT. Hes Pepe's cat, and hes tired of living in his owners shadow. Now, hes stepping into the spotlight to make his own mark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pt_GG_Mr_D4_400x400_ac32f15e9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

