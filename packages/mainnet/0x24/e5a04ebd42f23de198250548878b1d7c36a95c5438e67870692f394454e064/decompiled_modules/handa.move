module 0x24e5a04ebd42f23de198250548878b1d7c36a95c5438e67870692f394454e064::handa {
    struct HANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDA>(arg0, 6, b"HANDA", b"HANDALA", b"Hanzala or Hanthala, is a national allegorical figure of Palestine. The character was created in 1969 by the press cartoonist Naji al-Ali and took its current form in 1973.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733516382910.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

