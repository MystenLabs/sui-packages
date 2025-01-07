module 0x40fc85e6c44a34464d6692df9e0bbd1546f52d7b503cb21e9bdaaadef17b3589::qlnai {
    struct QLNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QLNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QLNAI>(arg0, 6, b"QLNAI", b"Qualoo Node AI ", b"Sui Network's 1st Depin Project Governing and Optimizing Global Internet Experience. JOIN THE WAITLIST NOW!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736235800164.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QLNAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QLNAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

