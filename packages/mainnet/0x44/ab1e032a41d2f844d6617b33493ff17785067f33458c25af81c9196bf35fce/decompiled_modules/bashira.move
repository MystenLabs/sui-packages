module 0x44ab1e032a41d2f844d6617b33493ff17785067f33458c25af81c9196bf35fce::bashira {
    struct BASHIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASHIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASHIRA>(arg0, 6, b"Bashira", b"PochitaMother", b"Pochita's Mother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_103608_321_91dc961ee7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASHIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASHIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

