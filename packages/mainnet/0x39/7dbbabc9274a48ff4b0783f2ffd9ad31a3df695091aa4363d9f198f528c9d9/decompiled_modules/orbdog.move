module 0x397dbbabc9274a48ff4b0783f2ffd9ad31a3df695091aa4363d9f198f528c9d9::orbdog {
    struct ORBDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBDOG>(arg0, 6, b"Orbdog", b"Orbeez Dog", b"$Orbdog is the most daring dog on the blockchain. He only eats Orbeez and Jeets, and the occasional bacon egg & cheese sandwich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_22c72e6b8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORBDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

