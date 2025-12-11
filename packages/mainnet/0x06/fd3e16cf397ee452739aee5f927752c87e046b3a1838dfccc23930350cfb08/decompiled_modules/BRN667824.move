module 0x6fd3e16cf397ee452739aee5f927752c87e046b3a1838dfccc23930350cfb08::BRN667824 {
    struct BRN667824 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRN667824, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRN667824>(arg0, 9, 0x1::string::utf8(b"BRN667824"), 0x1::string::utf8(b"Burn Test Token 1765474667824"), 0x1::string::utf8(b"Token for testing burn operations"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRN667824>>(0x2::coin_registry::finalize<BRN667824>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BRN667824>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRN667824>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRN667824>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

