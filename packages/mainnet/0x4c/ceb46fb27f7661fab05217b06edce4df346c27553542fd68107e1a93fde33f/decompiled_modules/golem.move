module 0x4cceb46fb27f7661fab05217b06edce4df346c27553542fd68107e1a93fde33f::golem {
    struct GOLEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLEM>(arg0, 6, b"GOLEM", b"Golem Club", b"Get ready to meme your way to the moon with our crypto craziness! No FOMO, just fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qa_DVLM_Oa_400x400_5a6bafccb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

