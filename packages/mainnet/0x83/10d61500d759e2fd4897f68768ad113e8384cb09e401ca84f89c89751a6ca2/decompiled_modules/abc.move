module 0x8310d61500d759e2fd4897f68768ad113e8384cb09e401ca84f89c89751a6ca2::abc {
    struct ABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABC>(arg0, 9, b"ABC", b"Alphabet", b"Memetoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e5f248a-d935-4594-bbcb-c888c5fe29f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

