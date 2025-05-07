module 0x22738c5667573e850ec2ccb2a77b25d1ca6d8ab77643878ab6783e470bcb3296::kiros {
    struct KIROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIROS>(arg0, 6, b"KIROS", b"Kiros", b"The trenches are bleeding, the jungle is starving, and the old kings have fallen. But fear not, for KIROS has arrived. A white lion forged in the fires of degen warfare, $KIROS is here to lead the charge, hunt down gains, and restore dominance to the Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kiros_logo_7121709062.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

