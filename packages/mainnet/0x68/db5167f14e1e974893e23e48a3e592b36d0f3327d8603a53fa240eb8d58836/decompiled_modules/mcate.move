module 0x68db5167f14e1e974893e23e48a3e592b36d0f3327d8603a53fa240eb8d58836::mcate {
    struct MCATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCATE>(arg0, 6, b"MCATE", b"MOON CATE", b"MOONCATE brings strong energy with our leadership and the developer team has had many successful projects, bringing huge profits and joy to investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726732380154_479518ab1abfc521b8883ee95d204618_08c22e1fe4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

