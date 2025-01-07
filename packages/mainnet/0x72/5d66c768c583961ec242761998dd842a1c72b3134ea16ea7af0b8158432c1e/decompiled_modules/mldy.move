module 0x725d66c768c583961ec242761998dd842a1c72b3134ea16ea7af0b8158432c1e::mldy {
    struct MLDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLDY>(arg0, 6, b"MLDY", b"Milady", x"546865206d6f737420706f70756c61727a206d656d65206172747a206c616e64696e67206f6e205355490a4772616369617a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240413_225107_1775774ed2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

