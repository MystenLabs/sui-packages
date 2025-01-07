module 0xed446a1b53ccf9bc23d1304ae4a16eff1dce0c5cb74a4a5f11e5ea3442f5c207::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"America Pac", x"52656164200a40416d65726963610a20746f20756e6465727374616e642077687920496d20737570706f7274696e67205472756d7020666f7220507265736964656e740a0a546865416d65726963615041432e6f72670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8w4_CZH_To_400x400_6502881184.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

