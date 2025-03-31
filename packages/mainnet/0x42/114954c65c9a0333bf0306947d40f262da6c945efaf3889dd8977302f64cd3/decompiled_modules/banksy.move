module 0x42114954c65c9a0333bf0306947d40f262da6c945efaf3889dd8977302f64cd3::banksy {
    struct BANKSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANKSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANKSY>(arg0, 9, b"BANKSY", b"BANKSY.AI", b"Burn Tokens | Create Magic | Stay Private", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://banksy.ai/wp-content/uploads/2024/12/Banksy.Ai_Updated.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANKSY>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANKSY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANKSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

