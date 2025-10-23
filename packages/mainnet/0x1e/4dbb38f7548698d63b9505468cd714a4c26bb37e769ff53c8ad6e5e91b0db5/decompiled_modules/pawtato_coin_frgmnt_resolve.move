module 0x1e4dbb38f7548698d63b9505468cd714a4c26bb37e769ff53c8ad6e5e91b0db5::pawtato_coin_frgmnt_resolve {
    struct PAWTATO_COIN_FRGMNT_RESOLVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_RESOLVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_RESOLVE>(arg0, 9, b"FRGMT_RESOLVE", b"Pawtato Fragment of Resolve", b"Whispers of unbroken will echo through this shard. Those who hold it feel the quiet strength to keep moving when all seems lost.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-resolve.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_RESOLVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_RESOLVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

