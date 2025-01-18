module 0x3818ed2b2b276fd9195342e2398c250e25b706f24c1a8e3dc4d93c77be824234::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 9, b"BBS", b"Babysex", b"SEX COIN . DAILY DRAW FOR THE MEETING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/23f0d2dc3a278f6efcce58872f91ac28blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

