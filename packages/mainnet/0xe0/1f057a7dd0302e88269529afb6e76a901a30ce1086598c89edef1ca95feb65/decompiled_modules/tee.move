module 0xe01f057a7dd0302e88269529afb6e76a901a30ce1086598c89edef1ca95feb65::tee {
    struct TEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEE>(arg0, 9, b"TEE", b"Omontee", b"For the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f4230bc-89a6-40ad-a73f-e8fa20c01f11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

