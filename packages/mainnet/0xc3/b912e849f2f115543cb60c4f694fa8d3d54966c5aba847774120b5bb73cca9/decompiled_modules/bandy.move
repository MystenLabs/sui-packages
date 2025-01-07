module 0xc3b912e849f2f115543cb60c4f694fa8d3d54966c5aba847774120b5bb73cca9::bandy {
    struct BANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDY>(arg0, 6, b"BANDY", b"Baby Andy", b"Baby Andy, the pint-sized bundle of joy with a smile that could light up the whole SUI nursery!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_09_51_12_f53ae5ef10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

