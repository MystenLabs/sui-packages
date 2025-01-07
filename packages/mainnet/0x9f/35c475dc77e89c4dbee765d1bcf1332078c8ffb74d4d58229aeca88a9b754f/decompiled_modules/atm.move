module 0x9f35c475dc77e89c4dbee765d1bcf1332078c8ffb74d4d58229aeca88a9b754f::atm {
    struct ATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATM>(arg0, 6, b"ATM", b"catdogbullfrogsmokingfishwifhat", x"6869206920616d20736c6974656c792072656874617264206b617420646f67672062756c2066726f6720736d6f6b65696e67206669736820776966206861740a77756820697a2041544d3f2061736b20666973680a6d617962652066697368206e6f7a652063757a206669736820697a20736d72740a627574206669736820746f6f2062697a7a7920736d6f6b696e27", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ATM_4b2115bfe8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATM>>(v1);
    }

    // decompiled from Move bytecode v6
}

