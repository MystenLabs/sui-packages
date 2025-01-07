module 0xc0050287b866766274f79e627caa5e2cb35aa6617d0bf8644c430c15bd475307::trumpx {
    struct TRUMPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPX>(arg0, 6, b"TRUMPX", b"Trump verse", b"Trump understands where America is headed. Theres just no one else for the job.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000761894_44f1d843bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

