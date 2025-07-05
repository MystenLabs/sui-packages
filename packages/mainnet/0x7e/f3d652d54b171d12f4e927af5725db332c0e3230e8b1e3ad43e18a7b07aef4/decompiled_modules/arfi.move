module 0x7ef3d652d54b171d12f4e927af5725db332c0e3230e8b1e3ad43e18a7b07aef4::arfi {
    struct ARFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARFI>(arg0, 6, b"ARFI", b"Aid Relief Lofi", b"Inspired by the Lofi movement's uplifting vision of a brighter future, ARFI (Aid Relief Lo-Fi Inspired) is dedicated to supporting the less fortunate in the Philippines. Through a step-by-step approach, we aim to provide meaningful assistance, foster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751689194961.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

