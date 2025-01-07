module 0x8cc6b7fb4a9da545d92196dd8fcd37d47c59b358974f4326c7d24cfca0e7182::hugeea {
    struct HUGEEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUGEEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUGEEA>(arg0, 6, b"HUGEEa", b"HUGEE", x"73206461696c792074726164696e6720766f6c756d652073757267656420706173742024383030206d696c6c696f6e2e0a38", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/a_C_Os_P_Mt_R_400x400_421e61a973.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUGEEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUGEEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

