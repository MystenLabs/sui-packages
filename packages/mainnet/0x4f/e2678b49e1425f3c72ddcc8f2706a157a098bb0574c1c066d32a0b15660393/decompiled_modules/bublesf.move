module 0x4fe2678b49e1425f3c72ddcc8f2706a157a098bb0574c1c066d32a0b15660393::bublesf {
    struct BUBLESF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBLESF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBLESF>(arg0, 6, b"BUBLESF", b"Bubles and Fishy", b"The first in a playful series that asks the deeper question of what we consider real. Is the visual perception of a thing enough to make it real, must we touch, feel and smell it... Is Bubles the cat more real then Fishy who swims endless loops across a rendered monitor... Perhaps we are all just rendered in vibrations of atomic energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_42_e4d9d517e1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBLESF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBLESF>>(v1);
    }

    // decompiled from Move bytecode v6
}

