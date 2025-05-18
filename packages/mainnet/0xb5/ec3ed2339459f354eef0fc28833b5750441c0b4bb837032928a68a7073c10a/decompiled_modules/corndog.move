module 0xb5ec3ed2339459f354eef0fc28833b5750441c0b4bb837032928a68a7073c10a::corndog {
    struct CORNDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORNDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORNDOG>(arg0, 6, b"CORNDOG", b"DO NOT BUY!!!", b"Do not buy. Launching Soon. #sui #cult. Official announcement will be made here. join TG for launch updates.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidixlg73smi46ywxpi4dgxuakbvlvl6tlf3po3gyzujr55kajzdeq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORNDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CORNDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

