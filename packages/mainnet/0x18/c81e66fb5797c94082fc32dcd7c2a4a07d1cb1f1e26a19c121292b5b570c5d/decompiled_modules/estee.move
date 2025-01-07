module 0x18c81e66fb5797c94082fc32dcd7c2a4a07d1cb1f1e26a19c121292b5b570c5d::estee {
    struct ESTEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTEE>(arg0, 6, b"Estee", b"Shiba Real Name", b"Shiba Inu real name is Estee the proof is in the tweet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/estee_5880eb475b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESTEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

