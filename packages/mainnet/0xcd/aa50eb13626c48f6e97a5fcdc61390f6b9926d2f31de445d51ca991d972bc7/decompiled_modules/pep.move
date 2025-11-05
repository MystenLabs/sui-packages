module 0xcdaa50eb13626c48f6e97a5fcdc61390f6b9926d2f31de445d51ca991d972bc7::pep {
    struct PEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEP>(arg0, 6, b"PEP", b"PEPEMOM", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1762331589679.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

