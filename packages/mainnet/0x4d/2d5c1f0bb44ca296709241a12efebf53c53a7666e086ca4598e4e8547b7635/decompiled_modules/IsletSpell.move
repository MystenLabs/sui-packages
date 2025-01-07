module 0x4d2d5c1f0bb44ca296709241a12efebf53c53a7666e086ca4598e4e8547b7635::IsletSpell {
    struct ISLETSPELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISLETSPELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISLETSPELL>(arg0, 0, b"COS", b"Islet Spell", b"A voice led you ashore... a song led you astray...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Islet_Spell.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISLETSPELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISLETSPELL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

