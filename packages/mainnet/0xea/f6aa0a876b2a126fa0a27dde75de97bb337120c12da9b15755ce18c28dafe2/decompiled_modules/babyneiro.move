module 0xeaf6aa0a876b2a126fa0a27dde75de97bb337120c12da9b15755ce18c28dafe2::babyneiro {
    struct BABYNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYNEIRO>(arg0, 6, b"BabyNeiro", b"Baby Neiro Sui", b"Bring Baby Neiro home! Join the community and be part of the cutest memecoin journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x303c89f3a4a58872d8b6a3e64c14fdd9ec669c99_0f92e02b97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

