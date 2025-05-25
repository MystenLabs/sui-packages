module 0xf08f57dbbc224521a1453d9690c5b4e322f531b7796bed8cfb454625a087bafa::kiros {
    struct KIROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIROS>(arg0, 6, b"KIROS", b"Kiros", b"The trenches are bleeding, the jungle is starving, and the old kings have fallen. But fear not, for KIROS has arrived. A white lion forged in the fires of degen warfare, $KIROS is here to lead the charge, hunt down gains, and restore dominance to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kiros_logo_fcf1ac81aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

