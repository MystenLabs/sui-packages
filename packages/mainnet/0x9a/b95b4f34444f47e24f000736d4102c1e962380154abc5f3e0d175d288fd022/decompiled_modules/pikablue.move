module 0x9ab95b4f34444f47e24f000736d4102c1e962380154abc5f3e0d175d288fd022::pikablue {
    struct PIKABLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKABLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKABLUE>(arg0, 6, b"PIKABLUE", b"PikaBlue", x"50494b4143485520424c55453a205468652043727970746f2045766f6c7574696f6e200a0a496e74726f647563696e672050494b4120424c5545206f6e207468652053554920436861696e202d20776865726520656c65637472696320656e65726779206d65657473206171756174696320706f77657220666f722061206d6f6f6e20657870657269656e63653a0a0a4a6f696e207468652045766f6c7574696f6e3a2047657420796f75722050494b41424c554520746f6b656e73206e6f7720616e6420737061726b20796f757220667574757265206f6e207468652053554920436861696e202120546865206e65787420534f4c414e41", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_990e2fc782.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKABLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKABLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

