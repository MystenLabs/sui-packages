module 0x385c369d9c4b196937d4c5ea54b7a216c77db85b76412e4473fc3cacc5cf27ef::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 6, b"DEV", b"Mankini", b"Founder & CEO of The New World Order invoking smiles, wonder and nods of recognition from those initiated in the know. In essence, $DEV meme token represents a unique cultural phenomenon, its value defined by collective belief and a personal narrative. The Man, The Myth, The Legend!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_29ac325cce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

