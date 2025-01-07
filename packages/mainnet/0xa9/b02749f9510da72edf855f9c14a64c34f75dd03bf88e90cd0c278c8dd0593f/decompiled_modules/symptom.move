module 0xa9b02749f9510da72edf855f9c14a64c34f75dd03bf88e90cd0c278c8dd0593f::symptom {
    struct SYMPTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMPTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMPTOM>(arg0, 6, b"Symptom", b"Sui Symptoms", b"Intelligence-related symptoms", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdgsdg_713fa456e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMPTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYMPTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

