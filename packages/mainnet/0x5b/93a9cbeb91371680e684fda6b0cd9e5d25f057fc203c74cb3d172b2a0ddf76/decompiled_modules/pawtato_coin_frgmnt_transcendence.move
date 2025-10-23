module 0x5b93a9cbeb91371680e684fda6b0cd9e5d25f057fc203c74cb3d172b2a0ddf76::pawtato_coin_frgmnt_transcendence {
    struct PAWTATO_COIN_FRGMNT_TRANSCENDENCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_TRANSCENDENCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_TRANSCENDENCE>(arg0, 9, b"FRGMT_TRANSCENDENCE", b"Pawtato Fragment of Transcendence", b"A faint light dances inside, as if the shard remembers stars that no longer exist. Those who harness it step beyond mortal limits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-transcendence.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_TRANSCENDENCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_TRANSCENDENCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

